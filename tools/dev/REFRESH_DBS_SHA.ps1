$ErrorActionPreference="Stop"
$ProgressPreference="SilentlyContinue"

param(
  [Parameter(Mandatory=$true)][string]$Path,
  [switch]$InPlace
)

function Get-FileSha256([string]$P) {
  return (Get-FileHash -Algorithm SHA256 -LiteralPath $P).Hash.ToLowerInvariant()
}

function Split-Frontmatter([string]$Text) {
  # Returns @{ has=$bool; fm=$string; body=$string; start=0; endLine=$int }
  $lines = $Text -split "`r?`n"
  if ($lines.Length -lt 3) { return @{ has=$false } }
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
  $lines = $Fm -split "`r?`n"

  # 1) Replace an existing "sha256:" line (common in your DBS under odp_compiler_contract)
  for ($i=0; $i -lt $lines.Length; $i++) {
    if ($lines[$i] -match "^\s*sha256\s*:\s*") {
      $indent = ([Regex]::Match($lines[$i], "^\s*")).Value
      $lines[$i] = "${indent}sha256: $Sha"
      return ($lines -join "`n")
    }
  }

  # 2) If missing, try to insert under "odp_compiler_contract:" block if present
  for ($i=0; $i -lt $lines.Length; $i++) {
    if ($lines[$i] -match "^\s*odp_compiler_contract\s*:\s*$") {
      # insert next line with two-space indent more than the block line
      $blockIndent = ([Regex]::Match($lines[$i], "^\s*")).Value
      $ins = "${blockIndent}  sha256: $Sha"
      $before = @()
      if ($i -ge 0) { $before = $lines[0..$i] }
      $after = @()
      if ($i+1 -le $lines.Length-1) { $after = $lines[($i+1)..($lines.Length-1)] }
      return (@($before + $ins + $after) -join "`n")
    }
  }

  # 3) Otherwise append at end (still inside frontmatter)
  return (($lines + "sha256: $Sha") -join "`n")
}

if (!(Test-Path -LiteralPath $Path)) { throw "FATAL: missing file: $Path" }

$text = Get-Content -LiteralPath $Path -Raw
$sha = Get-FileSha256 $Path

$parts = Split-Frontmatter $text
if (!$parts.has) {
  throw "FATAL: DBS frontmatter missing. Add a YAML frontmatter block delimited by --- at the top."
}

$newFm = Update-FrontmatterSha $parts.fm $sha
$newText = "---`n$newFm`n---`n$($parts.body)"
if ($newText -ne $text) {
  if ($InPlace) {
    Set-Content -LiteralPath $Path -Value $newText -Encoding utf8 -NoNewline
  }
  Write-Host "DBS_SHA256_COMPUTED=$sha"
  Write-Host "DBS_SHA_REFRESHED=1"
} else {
  Write-Host "DBS_SHA256_COMPUTED=$sha"
  Write-Host "DBS_SHA_REFRESHED=0"
}
