$ErrorActionPreference = 'Stop'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url64         = 'https://github.com/junegunn/fzf/releases/download/v0.74.1/fzf-0.74.1-windows_amd64.zip'
$checksum64    = 'd83a94a68a9203f6366754123c0e4d7a61e16be18a5d845f4838664b330c4f5f'
$urlArm64      = 'https://github.com/junegunn/fzf/releases/download/v0.74.1/fzf-0.74.1-windows_arm64.zip'
$checksumArm64 = 'B688ECAFA2D1FDB0AF3383F25D6D122866C13AD7CC996E9F735BF90E6C75F83F'

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
