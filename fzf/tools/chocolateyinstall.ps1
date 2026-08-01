$ErrorActionPreference = 'Stop'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url64         = 'https://github.com/junegunn/fzf/releases/download/v0.74.2/fzf-0.74.2-windows_amd64.zip'
$checksum64    = 'a5a3b27dd203469139d10669721952335b9b46f19346e3d1abc102a67ea60804'
$urlArm64      = 'https://github.com/junegunn/fzf/releases/download/v0.74.2/fzf-0.74.2-windows_arm64.zip'
$checksumArm64 = '287075F98E5D0A4DFF5BD4E800846CB3B5986B89B2E558B75D21A643A90D13EC'

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
