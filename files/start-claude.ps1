param (
    [string]$name
)

# Ensure $args[0] is set to something
if ($args[0]) { Set-Location $args[0] }

$cwd = (Get-Location).Path
$projectDirName = $cwd -replace '[:\\ _]', '-'
$projectDir = "$env:USERPROFILE\.claude\projects\$projectDirName"

# Locate a prior session for this project directory
$hasPrior = (Get-ChildItem -Path $projectDir -Filter "*.jsonl" -ErrorAction SilentlyContinue | Measure-Object).Count -gt 0

if ($hasPrior) {
  Write-Host "Continuing prior session $name..."
  claude --ide --continue -n $name
} else {
  Write-Host "Starting new session $name..."
  claude --ide -n $name
}
