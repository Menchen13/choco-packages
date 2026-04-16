$ErrorActionPreference = 'Stop'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'MSI'
  url64bit      = 'https://developers.yubico.com/yubikey-manager/Releases/yubikey-manager-5.9.1-win64.msi'

  softwareName  = 'YubiKey Manager CLI'

  checksum64    = 'A8CDFD148886E61C55AD91D41FB353F218CD304F817D435B12765800E0FBBF12'
  checksumType64= 'sha256'

  silentArgs    = "/qn /norestart /l*v `"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
  validExitCodes= @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
