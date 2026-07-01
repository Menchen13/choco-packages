$ErrorActionPreference = 'Stop'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'MSI'
  url64bit      = 'https://developers.yubico.com/yubikey-manager/Releases/yubikey-manager-5.9.2-win64.msi'

  softwareName  = 'YubiKey Manager CLI'

  checksum64    = '54E5830C56FAFCDDE80037DE490A88DE4FE3AFC398FC2AD7CCBFFCFC6B93BE9F'
  checksumType64= 'sha256'

  silentArgs    = "/qn /norestart /l*v `"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
  validExitCodes= @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
