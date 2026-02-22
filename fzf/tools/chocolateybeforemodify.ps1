$ErrorActionPreference = 'Stop'
$processName = 'fzf'

Write-Host "Checking for running '$processName' processes..."
$processes = Get-Process -Name $processName -ErrorAction SilentlyContinue

if ($processes) {
    Write-Host "Found running '$processName' processes. Terminating them to release file locks..."
    $processes | Stop-Process -Force -ErrorAction SilentlyContinue
    
    Start-Sleep -Seconds 2 
} else {
    Write-Host "No running '$processName' processes found."
}
