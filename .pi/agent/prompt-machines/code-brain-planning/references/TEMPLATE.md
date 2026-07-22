---
date: "<YYYY-MM-DD>"
status: draft
---

# <Plan title>

## Problem

<The current user or system problem this plan resolves.>

## Goal

<The outcome this plan must deliver.>

## Out of Scope

- <Consciously excluded work, or "None.">

## Context

<Current behavior, constraints, and evidence needed by a fresh-context worker.>

## Acceptance Criteria

- <Observable condition that must hold when the plan is complete.>

## Files

- `<path>` — <change and reason>

## Implementation

### 1. <Step name>

**Seam:** <Highest existing public seam that observes this behavior.>

**Red:** <Test that fails for the intended reason.>

**Green:** <Smallest implementation that passes the test.>

<For every code change in this step, name each affected path and show a unified diff with enough context to distinguish current code from proposed code. Use /dev/null and show the full contents for a small new file.>

**`<repository-relative/path.ext>`**

```diff
-<current code, API shape, schema, query, configuration, or component tree>
+<proposed replacement>
```

## Execution Slices

<!-- Omit when the plan fits one fresh worker context. -->

1. **<Slice title>** — delivers <observable behavior>; implementation steps <N–N>; acceptance criteria <items>; blocked by <slices or None>; verify with `<command>`.

## Test Strategy

<Coverage required beyond the TDD steps.>

## Verification

```bash
<commands with expected outcomes>
```

## Risks

- <Risk and mitigation.>

## Questions

- <Question that must be answered before implementation, or "None.">

## Evidence

- repo: `relative/path.ts` @ `<full SHA>` — inspected YYYY-MM-DD
- external: <https://example.com/spec> — accessed YYYY-MM-DD

## References

- [Context notes](./notes.md)
- <Relevant Code Brain ADR or sibling artifact.>
