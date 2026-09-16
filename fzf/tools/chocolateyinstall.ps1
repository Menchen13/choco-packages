$ErrorActionPreference = 'Stop'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url64         = 'https://github.com/junegunn/fzf/releases/download/v0.74.4/fzf-0.74.4-windows_amd64.zip'
$checksum64    = '5e63c0e798406fcb9c51a9fed4988398e25fdabf8c670e32c16caf7b4a7ed02d'
$urlArm64      = 'https://github.com/junegunn/fzf/releases/download/v0.74.4/fzf-0.74.4-windows_arm64.zip'
$checksumArm64 = '558DF4DAC9C65A63C732909A06ABC1891A42ADCAE4D6BE92A9B0CCC0EF05B4FF'

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
