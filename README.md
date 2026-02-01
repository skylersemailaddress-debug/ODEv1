# ODE Autoprogram (v5 Robot Mode)

You said it plainly: **“If it’s green it’s good.”**

This repo is set up so you don’t have to babysit hashes, approvals, or merge rituals.

## Your only rule
- **Green ✅ = merge (or it auto-merges)**
- **Red ❌ = don’t touch it**

## What’s automated
- DBS declared `sha256` is refreshed automatically (no manual edits)
- Gates run fail-closed
- DBS compiles to `out/DBP.json`
- DBP executes to `out/EXECUTION_PROOF.json`
- Proof artifacts uploaded every run

## One command (GitHub)
```powershell
$repo = "<owner>/<repo>"
gh workflow run ode_autoprogram.yml --repo $repo
```

## One command (local)
```powershell
pwsh -NoProfile -File tools/run/RUN_AUTOPROGRAM.ps1
```
## Sanity check (one-time)
Run this once after you unzip/commit to confirm repo settings are correct:
```powershell
$repo = "<owner>/<repo>"
gh workflow run ode_setup_sanity.yml --repo $repo
```
Then open the workflow run and read the **Job Summary**. Fix anything flagged.


## Required GitHub settings (do this once)
### 1) Enable Auto-merge
Repo Settings → Pull Requests → enable **Auto-merge**.

### 2) Protect main (prevents accidental red merges)
Repo Settings → Branches → add rule for `main`:
- Require pull request
- Require status checks to pass: **ODE Autoprogram**
- Require branches up to date

### 3) Robot auto-merge workflow
This repo includes `.github/workflows/ode_automerge_green.yml` which:
- auto-labels safe PRs with `automerge`
- enables GitHub auto-merge (squash) when possible
- will **not** automerge fork PRs (security)

If Auto-merge is enabled and checks go green, merges happen automatically.
