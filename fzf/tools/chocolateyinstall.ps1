$ErrorActionPreference = 'Stop'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url64         = 'https://github.com/junegunn/fzf/releases/download/v0.71.0/fzf-0.71.0-windows_amd64.zip'
$checksum64    = '15bf30fa658c596d740f0ce9a9a97b6b5d90566124903657d09fd109dd0973d2'
$urlArm64      = 'https://github.com/junegunn/fzf/releases/download/v0.71.0/fzf-0.71.0-windows_arm64.zip'
$checksumArm64 = '9D0DE41E8C40E8A7AC1EDB64FE93AAE96181ED93439E9E6D8D35DEDA61EE910B'

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
