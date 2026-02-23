$ErrorActionPreference = 'Stop'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url64         = 'https://github.com/junegunn/fzf/releases/download/v0.68.0/fzf-0.68.0-windows_amd64.zip'
$checksum64    = '4939ed89f3a75258ea47c55c34422b6b3f28e38b85dbd1e27dc4cf5839d5d310'
$urlArm64      = 'https://github.com/junegunn/fzf/releases/download/v0.68.0/fzf-0.68.0-windows_arm64.zip'
$checksumArm64 = '12B8E6554CBDB7C2669BBBAAF6E53B988EA74FFCA5FF828D3A7FC80B9F028A6C'

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
