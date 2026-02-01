$ErrorActionPreference="Stop"
$ProgressPreference="SilentlyContinue"

param(
  [string]$DBS = "dbs/MASTER_DBS.md",
  [string]$ABI = "examples/ABI_TEMPLATE.json"
)

# 1) Refresh DBS sha in-place (babysitter-free)
pwsh -NoProfile -File tools/dev/REFRESH_DBS_SHA.ps1 -Path $DBS -InPlace

# 2) Gates
pwsh -NoProfile -File tools/gates/RUN_ALL_GATES.ps1 -DBS $DBS -ABI $ABI

# 3) Compile
pwsh -NoProfile -File tools/run/RUN_COMPILE.ps1 -DBS $DBS -ABI $ABI

# 4) Execute
python src/executor/run_dbp.py --dbp out/DBP.json
