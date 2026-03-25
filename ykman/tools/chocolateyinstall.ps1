$ErrorActionPreference = 'Stop'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'MSI'
  url64bit      = 'https://developers.yubico.com/yubikey-manager/Releases/yubikey-manager-5.9.0-win64.msi'

  softwareName  = 'YubiKey Manager CLI'

  checksum64    = '83ADE485CB15C8F210C8FC1C382CFC0972069FD1E2C912AA17275484030B0B5B'
  checksumType64= 'sha256'

  silentArgs    = "/qn /norestart /l*v `"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
  validExitCodes= @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
