$ErrorActionPreference = 'Stop'

# 1. Unbind all USB devices gracefully
$usbipdExe = Get-Command "usbipd" -ErrorAction SilentlyContinue

if ($usbipdExe) {
    Write-Host "Unbinding all USB devices to prepare for upgrade/uninstall..."
    try {
        # The --all flag was added in later versions to unbind everything at once
        Start-Process -FilePath "usbipd" -ArgumentList "unbind", "--all" -Wait -NoNewWindow
    } catch {
        Write-Warning "Could not unbind devices automatically. If devices are actively attached, the upgrade might require a reboot."
    }
}

# 2. Stop the background service
$serviceName = "usbipd"
$service = Get-Service -Name $serviceName -ErrorAction SilentlyContinue

if ($service) {
    Write-Host "Stopping the $serviceName service..."
    try {
        Stop-Service -Name $serviceName -Force -ErrorAction Stop
        Write-Host "Service stopped successfully."
    } catch {
        Write-Warning "Failed to stop $serviceName. The installer will attempt to stop it, but a reboot might be required."
    }
}
