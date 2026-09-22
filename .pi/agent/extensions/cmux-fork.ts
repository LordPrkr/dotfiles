import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";
import { existsSync } from "node:fs";
import * as path from "node:path";

function shellQuote(value: string): string {
  return `'${value.replace(/'/g, `'"'"'`)}'`;
}

interface CmuxPanes {
  panes?: Array<{ id?: string; surface_ids?: string[] }>;
}

function getPiInvocationParts(): string[] {
  const currentScript = process.argv[1];
  if (currentScript && existsSync(currentScript)) {
    return [process.execPath, currentScript];
  }

  const executable = path.basename(process.execPath).toLowerCase();
  if (!/^(node|bun)(\.exe)?$/.test(executable)) {
    return [process.execPath];
  }

  return ["pi"];
}

export default function (pi: ExtensionAPI): void {
  pi.registerCommand("fork-right", {
    description: "Fork the current Pi session into a right-hand cmux pane. Usage: /fork-right [prompt]",
    handler: async (args, ctx) => {
      const sessionFile = ctx.sessionManager.getSessionFile();
      if (!sessionFile) {
        ctx.ui.notify("/fork-right requires a persisted Pi session.", "warning");
        return;
      }

      const workspace = process.env.CMUX_WORKSPACE_ID;
      if (!workspace) {
        ctx.ui.notify("/fork-right requires a cmux terminal workspace.", "warning");
        return;
      }

      const command = [
        "exec",
        ...getPiInvocationParts().map(shellQuote),
        "--fork",
        shellQuote(sessionFile),
        ...(args.trim() ? ["--", shellQuote(args.trim())] : []),
      ].join(" ");

      const panesBefore = await pi.exec("cmux", ["list-panes", "--workspace", workspace, "--id-format", "both", "--json"]);
      if (panesBefore.code !== 0) {
        const reason = panesBefore.stderr.trim() || panesBefore.stdout.trim() || "unknown cmux error";
        ctx.ui.notify(`Failed to inspect the cmux workspace: ${reason}`, "error");
        return;
      }

      let existingPaneIds: Set<string>;
      try {
        existingPaneIds = new Set((JSON.parse(panesBefore.stdout) as CmuxPanes).panes?.flatMap((pane) => pane.id ? [pane.id] : []) ?? []);
      } catch {
        ctx.ui.notify("Failed to read cmux pane information.", "error");
        return;
      }

      const created = await pi.exec("cmux", [
        "new-pane",
        "--workspace",
        workspace,
        "--direction",
        "right",
        "--focus",
        "false",
      ]);
      if (created.code !== 0) {
        const reason = created.stderr.trim() || created.stdout.trim() || "unknown cmux error";
        ctx.ui.notify(`Failed to create a cmux pane: ${reason}`, "error");
        return;
      }

      const panesAfter = await pi.exec("cmux", ["list-panes", "--workspace", workspace, "--id-format", "both", "--json"]);
      let surfaceId: string | undefined;
      if (panesAfter.code === 0) {
        try {
          surfaceId = (JSON.parse(panesAfter.stdout) as CmuxPanes).panes
            ?.find((pane) => pane.id && !existingPaneIds.has(pane.id))
            ?.surface_ids?.[0];
        } catch {
          // The notification below gives the user a clear recovery path.
        }
      }
      if (!surfaceId) {
        ctx.ui.notify("Created a cmux pane but could not find its terminal surface.", "error");
        return;
      }

      const launched = await pi.exec("cmux", ["send", "--workspace", workspace, "--surface", surfaceId, `${command}\n`]);
      if (launched.code !== 0) {
        const reason = launched.stderr.trim() || launched.stdout.trim() || "unknown cmux error";
        ctx.ui.notify(`Created a pane but failed to start the fork: ${reason}`, "error");
        return;
      }

      ctx.ui.notify("Forked the current session into a right-hand cmux pane.", "info");
    },
  });
}
