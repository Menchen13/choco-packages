$ErrorActionPreference = 'Stop'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url64         = 'https://github.com/junegunn/fzf/releases/download/v0.74.3/fzf-0.74.3-windows_amd64.zip'
$checksum64    = 'cf5c137d9b391c3988c54af8f5fc490ffbef6f70444651e7d57fdb45ad04c8bd'
$urlArm64      = 'https://github.com/junegunn/fzf/releases/download/v0.74.3/fzf-0.74.3-windows_arm64.zip'
$checksumArm64 = '7D70C25A1229F3BBFCB56B4314F298C16AD61A258F9641B7ACF08C513A40BD29'

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
