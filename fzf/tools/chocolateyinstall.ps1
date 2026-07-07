$ErrorActionPreference = 'Stop'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url64         = 'https://github.com/junegunn/fzf/releases/download/v0.74.0/fzf-0.74.0-windows_amd64.zip'
$checksum64    = '614efa4ea923a3d6715856b5f6fb6ce815acdb0ce549e7499202808f7a7a78e7'
$urlArm64      = 'https://github.com/junegunn/fzf/releases/download/v0.74.0/fzf-0.74.0-windows_arm64.zip'
$checksumArm64 = '2F18464BB2088889C0EE58C3B280DC264911EB70C330BC930D39A8F93488393D'

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
  url64bit      = $url
  checksum64    = $checksum
  checksumType64= 'sha256'
}

Install-ChocolateyZipPackage @packageArgs
