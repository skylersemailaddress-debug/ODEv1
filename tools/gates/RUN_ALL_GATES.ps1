param(
  [Parameter(Mandatory=$true)][string]$DBS,
  [Parameter(Mandatory=$true)][string]$ABI
)

$ErrorActionPreference="Stop"
$ProgressPreference="SilentlyContinue"

function Fail([string]$Reason) {
  Write-Host "FAIL_REASON=$Reason"
  Write-Host "ALL_GATES_PASS=0"
  exit 1
}

function Get-FileSha256([string]$Path) {
  if (!(Test-Path -LiteralPath $Path)) { throw "FATAL: missing file: $Path" }
  return (Get-FileHash -Algorithm SHA256 -LiteralPath $Path).Hash.ToLowerInvariant()
}

function Get-Frontmatter([string]$Text) {
  $lines = $Text -split "`r?`n"
  if ($lines.Length -lt 3) { return $null }
  if ($lines[0].Trim() -ne "---") { return $null }
  $end = -1
  for ($i=1; $i -lt $lines.Length; $i++) {
    if ($lines[$i].Trim() -eq "---") { $end = $i; break }
  }
  if ($end -lt 0) { return $null }
  return ($lines[1..($end-1)] -join "`n")
}

function Try-Extract-FrontmatterField([string]$Frontmatter, [string]$Key) {
  $pat = "^(?m)\s*" + [Regex]::Escape($Key) + "\s*:\s*(.+?)\s*$"
  $m = [Regex]::Match($Frontmatter, $pat)
  if (!$m.Success) { return $null }
  $v = $m.Groups[1].Value.Trim()
  if (($v.StartsWith('"') -and $v.EndsWith('"')) -or ($v.StartsWith("'") -and $v.EndsWith("'"))) {
    $v = $v.Substring(1, $v.Length-2)
  }
  return $v
}

Write-Host "GATE_START=ODE_DBS_EXISTS"
if (!(Test-Path -LiteralPath $DBS)) { Fail "dbs_missing:$DBS" }
Write-Host "GATE_OK=ODE_DBS_EXISTS"

Write-Host "GATE_START=ODE_ABI_EXISTS"
if (!(Test-Path -LiteralPath $ABI)) { Fail "abi_missing:$ABI" }
Write-Host "GATE_OK=ODE_ABI_EXISTS"

Write-Host "GATE_START=ODE_ABI_JSON_PARSE"
try {
  $abiObj = Get-Content -LiteralPath $ABI -Raw | ConvertFrom-Json
} catch {
  Fail "abi_json_parse_failed"
}
if ($null -eq $abiObj.abi_id -or $null -eq $abiObj.abi_version) { Fail "abi_missing_required_fields" }
Write-Host "ABI_ID=$($abiObj.abi_id)"
Write-Host "ABI_VERSION=$($abiObj.abi_version)"
Write-Host "GATE_OK=ODE_ABI_JSON_PARSE"

Write-Host "GATE_START=ODE_DBS_SHA_CHECK"
$dbsText = Get-Content -LiteralPath $DBS -Raw
$dbsSha = Get-FileSha256 $DBS
Write-Host "DBS_SHA256_COMPUTED=$dbsSha"

$fm = Get-Frontmatter $dbsText
if ($null -eq $fm) { Fail "dbs_frontmatter_missing" }

$declared = Try-Extract-FrontmatterField $fm "sha256"
if ($null -eq $declared) { $declared = Try-Extract-FrontmatterField $fm "odp_compiler_contract.sha256" }
if ($null -eq $declared) { Fail "dbs_frontmatter_sha256_missing" }

$declared = $declared.ToLowerInvariant()
Write-Host "DBS_SHA256_DECLARED=$declared"
if ($declared -ne $dbsSha) { Fail "dbs_sha_mismatch" }

Write-Host "GATE_OK=ODE_DBS_SHA_CHECK"

Write-Host "GATE_START=ODE_DBS_COMPILER_CONTRACT"
$id = Try-Extract-FrontmatterField $fm "id"
if ($null -eq $id) { $id = Try-Extract-FrontmatterField $fm "odp_compiler_contract.id" }
$ver = Try-Extract-FrontmatterField $fm "version"
if ($null -eq $ver) { $ver = Try-Extract-FrontmatterField $fm "odp_compiler_contract.version" }
if ($null -eq $id -or $null -eq $ver) { Fail "dbs_compiler_contract_missing_fields" }

Write-Host "APP_ID=$id"
Write-Host "APP_VERSION=$ver"
Write-Host "GATE_OK=ODE_DBS_COMPILER_CONTRACT"

Write-Host "ALL_GATES_PASS=1"
exit 0
