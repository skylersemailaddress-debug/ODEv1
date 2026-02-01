param(
  [Parameter(Mandatory=$true)][string]$Path,
  [switch]$InPlace
)

$ErrorActionPreference="Stop"
$ProgressPreference="SilentlyContinue"

function Get-FileSha256([string]$P) {
  return (Get-FileHash -Algorithm SHA256 -LiteralPath $P).Hash.ToLowerInvariant()
}

function Split-Frontmatter([string]$Text) {
  $lines = $Text -split "`r?`n"
  if ($lines.Length -lt 1) { return @{ has=$false } }
  if ($lines[0].Trim() -ne "---") { return @{ has=$false } }
  $end = -1
  for ($i=1; $i -lt $lines.Length; $i++) {
    if ($lines[$i].Trim() -eq "---") { $end = $i; break }
  }
  if ($end -lt 0) { return @{ has=$false } }
  $fm = ($lines[1..($end-1)] -join "`n")
  $body = ($lines[($end+1)..($lines.Length-1)] -join "`n")
  return @{ has=$true; fm=$fm; body=$body; end=$end }
}

function Update-FrontmatterSha([string]$Fm, [string]$Sha) {
  $lines = $Fm -split "`r?`n"

  for ($i=0; $i -lt $lines.Length; $i++) {
    if ($lines[$i] -match "^\s*sha256\s*:\s*") {
      $indent = ([Regex]::Match($lines[$i], "^\s*")).Value
      $lines[$i] = "${indent}sha256: $Sha"
      return ($lines -join "`n")
    }
  }

  # If there's an odp_compiler_contract block, add sha inside it.
  for ($i=0; $i -lt $lines.Length; $i++) {
    if ($lines[$i] -match "^\s*odp_compiler_contract\s*:\s*$") {
      $blockIndent = ([Regex]::Match($lines[$i], "^\s*")).Value
      $ins = "${blockIndent}  sha256: $Sha"
      $before = @(); if ($i -ge 0) { $before = $lines[0..$i] }
      $after  = @(); if ($i+1 -le $lines.Length-1) { $after  = $lines[($i+1)..($lines.Length-1)] }
      return (@($before + $ins + $after) -join "`n")
    }
  }

  return (($lines + "sha256: $Sha") -join "`n")
}

if (!(Test-Path -LiteralPath $Path)) { throw "FATAL: missing file: $Path" }

$text = Get-Content -LiteralPath $Path -Raw
$sha  = Get-FileSha256 $Path

$parts = Split-Frontmatter $text

if (!$parts.has) {
  # Robot mode: create minimal frontmatter automatically
  $fm = @(
    "id: ode.opsdeskecommerce"
    "version: 0.1.0"
    "sha256: $sha"
  ) -join "`n"

  $newText = "---`n$fm`n---`n$text"
  if ($InPlace) { Set-Content -LiteralPath $Path -Value $newText -Encoding utf8 }
  Write-Host "DBS_SHA256_COMPUTED=$sha"
  Write-Host "DBS_FRONTMATTER_CREATED=1"
  Write-Host "DBS_SHA_REFRESHED=1"
  exit 0
}

$newFm   = Update-FrontmatterSha $parts.fm $sha
$newText = "---`n$newFm`n---`n$($parts.body)"

if ($newText -ne $text) {
  if ($InPlace) { Set-Content -LiteralPath $Path -Value $newText -Encoding utf8 }
  Write-Host "DBS_SHA256_COMPUTED=$sha"
  Write-Host "DBS_FRONTMATTER_CREATED=0"
  Write-Host "DBS_SHA_REFRESHED=1"
} else {
  Write-Host "DBS_SHA256_COMPUTED=$sha"
  Write-Host "DBS_FRONTMATTER_CREATED=0"
  Write-Host "DBS_SHA_REFRESHED=0"
}
