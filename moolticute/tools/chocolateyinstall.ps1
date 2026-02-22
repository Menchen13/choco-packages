
$ErrorActionPreference = 'Stop'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$installDir = Join-Path $env:ProgramFiles "Moolticute"
$exePath = Join-Path $installDir "moolticute.exe"
$shortcutPath = Join-Path "$env:ProgramData\Microsoft\Windows\Start Menu\Programs" "Moolticute.lnk"


$url64      = 'https://github.com/mooltipass/moolticute/releases/download/v1.04.0/moolticute_setup_v1.04.0.exe'


$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url64bit      = $url64

  softwareName  = 'moolticute*'

  checksum64    = '33b70f41993d010149479af39800e020851faf05b7479d0c2c905d0344c08fe4'
  checksumType64= 'sha256'

  validExitCodes= @(0, 3010, 1641)
  silentArgs     = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP- /DIR=`"$installDir`""
}

Install-ChocolateyPackage @packageArgs
Install-BinFile -Name 'moolticute' -Path $exePath
Install-ChocolateyShortcut -shortcutFilePath $shortcutPath -targetPath $exePath -description "Moolticute"

















