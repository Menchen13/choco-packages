$ErrorActionPreference = 'Stop'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url64         = 'https://github.com/junegunn/fzf/releases/download/v0.75.0/fzf-0.75.0-windows_amd64.zip'
$checksum64    = 'e3fb809d48094bea7f9f4df03b2fea33ae6e28a6cd32fdad9970cd79e1103901'
$urlArm64      = 'https://github.com/junegunn/fzf/releases/download/v0.75.0/fzf-0.75.0-windows_arm64.zip'
$checksumArm64 = '56C9465827208BDFB7B8DFEE56FDD6A7E5932FF0341A659350A908DA885EBDCA'

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
