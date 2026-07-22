# Implementation Receipt

Create `plans/<NNN_TOPIC>/receipt.md` once and append one attempt section for every implementation attempt. Update frontmatter to describe the latest attempt; never erase earlier attempt sections.

```md
---
plan: ./plan.md
outcome: accepted # accepted | partial | blocked | reverted
attempted: "<YYYY-MM-DDTHH:MM:SS±HH:MM>"
review: passed # passed | findings-recorded | not-run
---

# Implementation Receipt

## Attempt — <YYYY-MM-DD HH:MM timezone>

### Delivery

<Observable result.>

### Changed files

- `<repository>: <relative path>` — <change>

### Verification

| Command | Exit code | Result |
| --- | ---: | --- |
| `<command>` | `0` | <concise output> |

### Review

<Reviewer disposition and findings.>

### Deviations and residual risks

- <Deviation, risk, or `None.`>

### Follow-up

- <Linked card/plan or `None.`>

### Source evidence

| Repository | Base revision | Result revision | Change-set SHA-256 |
| --- | --- | --- | --- |
| `leonard-lessons` | `<full SHA>` | `<full commit SHA or uncommitted>` | `<hash or none>` |
```

Include one source-evidence row per changed Git repository. Capture each base revision before implementation. A committed result uses its full delivered commit SHA and `none`; an uncommitted result uses `uncommitted` and the hash below. Never use the unchanged base SHA as proof of delivered work.

## Deterministic uncommitted change-set hash

Run this from any path inside the repository. It hashes `git diff --binary HEAD` followed by every untracked path, Git file mode, and content in sorted path order. Git expands untracked directories to files; symlinks contribute mode `120000` and their link target, while regular files contribute `100644` or `100755`. Framing prevents ambiguous concatenation.

```bash
python3 - <<'PY'
from pathlib import Path
import hashlib
import os
import subprocess

root = Path(subprocess.check_output(
    ["git", "rev-parse", "--show-toplevel"], text=True
).strip())
hash_ = hashlib.sha256()
def add(tag, data):
    hash_.update(tag + len(data).to_bytes(8, "big") + data)
add(b"diff", subprocess.check_output(
    ["git", "diff", "--binary", "HEAD", "--"], cwd=root
))
untracked = subprocess.check_output(
    ["git", "ls-files", "--others", "--exclude-standard", "-z"], cwd=root
).split(b"\0")
for raw_path in sorted(path for path in untracked if path):
    path = root / os.fsdecode(raw_path)
    if path.is_symlink():
        mode = b"120000"
        content = os.fsencode(os.readlink(path))
    else:
        mode = b"100755" if path.stat().st_mode & 0o111 else b"100644"
        content = path.read_bytes()
    add(b"path", raw_path)
    add(b"mode", mode)
    add(b"content", content)
print(hash_.hexdigest())
PY
```

For a later authorized commit, update that repository's evidence row to the delivered commit SHA and `none`, then append:

```md
## Commit finalization — <YYYY-MM-DD HH:MM timezone>

- Repository: `<name>`
- Result revision: `<full commit SHA>`
- Authorization: <what the user authorized>
```
