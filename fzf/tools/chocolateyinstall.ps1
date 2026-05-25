$ErrorActionPreference = 'Stop'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url64         = 'https://github.com/junegunn/fzf/releases/download/v0.73.1/fzf-0.73.1-windows_amd64.zip'
$checksum64    = '521a974dc32e93404265e55bffaf71a59e05e80abdf8ca4afb21a6030dc76f5f'
$urlArm64      = 'https://github.com/junegunn/fzf/releases/download/v0.73.1/fzf-0.73.1-windows_arm64.zip'
$checksumArm64 = '1B043FD2EEA42B210679BE71A15C0BE9516A4369CE5920F533E6B02EDB8736B9'

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
