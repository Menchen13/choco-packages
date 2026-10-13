$ErrorActionPreference = 'Stop'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url64         = 'https://github.com/junegunn/fzf/releases/download/v0.74.5/fzf-0.74.5-windows_amd64.zip'
$checksum64    = '01f854ec8b9b47c99a7d78023638f7d2056cfb0af56b72dabd112032eed3993e'
$urlArm64      = 'https://github.com/junegunn/fzf/releases/download/v0.74.5/fzf-0.74.5-windows_arm64.zip'
$checksumArm64 = '45D8F69B7660AC0C59118C9CCACCDEA305D56FDD74A3599AA357CBB374EBD61E'

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
