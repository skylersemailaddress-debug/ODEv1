$ErrorActionPreference="Stop"
$ProgressPreference="SilentlyContinue"

param(
  [Parameter(Mandatory=$true)][string]$DBS,
  [Parameter(Mandatory=$true)][string]$ABI
)

function Get-FileSha256([string]$Path) {
  return (Get-FileHash -Algorithm SHA256 -LiteralPath $Path).Hash.ToLowerInvariant()
}

if (!(Test-Path -LiteralPath $DBS)) { throw "FATAL: missing DBS: $DBS" }
if (!(Test-Path -LiteralPath $ABI)) { throw "FATAL: missing ABI: $ABI" }

$abiObj = Get-Content -LiteralPath $ABI -Raw | ConvertFrom-Json

New-Item -ItemType Directory -Force -Path out | Out-Null

$dbsSha = Get-FileSha256 $DBS
$abiSha = Get-FileSha256 $ABI

# Minimal DBP contract: stable keys, stable ordering (ConvertTo-Json preserves hashtable insertion order)
$dbp = [ordered]@{
  kind = "ode.dbp.v1"
  app = [ordered]@{
    id = [string]$abiObj.abi_id
    version = [string]$abiObj.abi_version
  }
  inputs = [ordered]@{
    dbs_path = $DBS
    dbs_sha256 = $dbsSha
    abi_path = $ABI
    abi_sha256 = $abiSha
  }
  plan = @(
    [ordered]@{ step="generate"; target="out/EXECUTION_PROOF.json" }
  )
}

($dbp | ConvertTo-Json -Depth 10) | Out-File -LiteralPath "out/DBP.json" -Encoding utf8
Write-Host "COMPILE_OK=1"
