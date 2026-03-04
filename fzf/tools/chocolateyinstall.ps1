$ErrorActionPreference = 'Stop'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url64         = 'https://github.com/junegunn/fzf/releases/download/v0.70.0/fzf-0.70.0-windows_amd64.zip'
$checksum64    = '7465a6738e2c844742df973459c7509aed2d10d7a72bfd6de201b867b4eda4cd'
$urlArm64      = 'https://github.com/junegunn/fzf/releases/download/v0.70.0/fzf-0.70.0-windows_arm64.zip'
$checksumArm64 = 'EAA12CA2E072EF8E8F89CA3D961FD886E46FBBC254C0C85C4786D813416A95D5'

if ($env:PROCESSOR_ARCHITECTURE -match 'ARM') {
    $url      = $urlArm64
    $checksum = $checksumArm64
} else {
    $url      = $url64
    $checksum = $checksum64
}

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  url64bit      = $url64
  checksum64    = $checksum
  checksumType64= 'sha256'
}

Install-ChocolateyZipPackage @packageArgs
