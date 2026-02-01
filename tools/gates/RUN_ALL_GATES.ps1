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

function Get-YamlScalar([string]$Yaml, [string]$Key) {
  # Top-level scalar: key: value
  $pat = "^(?m)\s*" + [Regex]::Escape($Key) + "\s*:\s*(.+?)\s*$"
  $m = [Regex]::Match($Yaml, $pat)
  if (!$m.Success) { return $null }
  $v = $m.Groups[1].Value.Trim()
  if (($v.StartsWith('"') -and $v.EndsWith('"')) -or ($v.StartsWith("'") -and $v.EndsWith("'"))) {
    $v = $v.Substring(1, $v.Length-2)
  }
  return $v
}

function Get-YamlNestedScalar([string]$Yaml, [string]$BlockKey, [string]$InnerKey) {
  # Minimal YAML nested block reader:
  # blockkey:
  #   innerkey: value
  $lines = $Yaml -split "`r?`n"
  $blockLineIdx = -1
  for ($i=0; $i -lt $lines.Length; $i++) {
    if ($lines[$i] -match ("^\s*" + [Regex]::Escape($BlockKey) + "\s*:\s*$")) { $blockLineIdx = $i; break }
  }
  if ($blockLineIdx -lt 0) { return $null }

  # Determine block indent
  $blockIndent = ([Regex]::Match($lines[$blockLineIdx], "^\s*")).Value.Length

  for ($j = $blockLineIdx + 1; $j -lt $lines.Length; $j++) {
    $line = $lines[$j]
    if ($line.Trim().Length -eq 0) { continue }

    $indent = ([Regex]::Match($line, "^\s*")).Value.Length
    if ($indent -le $blockIndent) { break } # left block

    $m = [Regex]::Match($line, "^\s*" + [Regex]::Escape($InnerKey) + "\s*:\s*(.+?)\s*$")
    if ($m.Success) {
      $v = $m.Groups[1].Value.Trim()
      if (($v.StartsWith('"') -and $v.EndsWith('"')) -or ($v.StartsWith("'") -and $v.EndsWith("'"))) {
        $v = $v.Substring(1, $v.Length-2)
      }
      return $v
    }
  }
  return $null
}

Write-Host "GATE_START=ODE_DBS_EXISTS"
if (!(Test-Path -LiteralPath $DBS)) { Fail "dbs_missing:$DBS" }
Write-Host "GATE_OK=ODE_DBS_EXISTS"

Write-Host "GATE_START=ODE_ABI_EXISTS"
if (!(Test-Path -LiteralPath $ABI)) { Fail "abi_missing:$ABI" }
Write-Host "GATE_OK=ODE_ABI_EXISTS"

Write-Host "GATE_START=ODE_ABI_JSON_PARSE"
try { $abiObj = Get-Content -LiteralPath $ABI -Raw | ConvertFrom-Json } catch { Fail "abi_json_parse_failed" }
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

$declared = Get-YamlScalar $fm "sha256"
if ($null -eq $declared) { $declared = Get-YamlNestedScalar $fm "odp_compiler_contract" "sha256" }
if ($null -eq $declared) { Fail "dbs_frontmatter_sha256_missing" }

$declared = $declared.ToLowerInvariant()
Write-Host "DBS_SHA256_DECLARED=$declared"
if ($declared -ne $dbsSha) { Fail "dbs_sha_mismatch" }
Write-Host "GATE_OK=ODE_DBS_SHA_CHECK"

Write-Host "GATE_START=ODE_DBS_COMPILER_CONTRACT"
$id = Get-YamlScalar $fm "id"
$ver = Get-YamlScalar $fm "version"
if ($null -eq $id) { $id = Get-YamlNestedScalar $fm "odp_compiler_contract" "id" }
if ($null -eq $ver) { $ver = Get-YamlNestedScalar $fm "odp_compiler_contract" "version" }
if ($null -eq $id -or $null -eq $ver) { Fail "dbs_compiler_contract_missing_fields" }

Write-Host "APP_ID=$id"
Write-Host "APP_VERSION=$ver"
Write-Host "GATE_OK=ODE_DBS_COMPILER_CONTRACT"

Write-Host "ALL_GATES_PASS=1"
exit 0
