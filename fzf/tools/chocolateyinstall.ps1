$ErrorActionPreference = 'Stop'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url64         = 'https://github.com/junegunn/fzf/releases/download/v0.72.0/fzf-0.72.0-windows_amd64.zip'
$checksum64    = 'cce66ae7e442030334927bfbfd917690713e63d215aba93027f99807828fe239'
$urlArm64      = 'https://github.com/junegunn/fzf/releases/download/v0.72.0/fzf-0.72.0-windows_arm64.zip'
$checksumArm64 = '186AF4F9D30434B4EB34D670312D96FB7886A10C4C1CE9C64453DD0FA19AEDEC'

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
