$ErrorActionPreference = 'Stop' # stop on all errors
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url = 'https://github.com/godotengine/godot-builds/releases/download/4.2-beta2/Godot_v4.2-beta2_win32.exe.zip'
$checksum = '7383518fd219695afb04ff5e189ce88151e441f3d2a9460967b87fa639bbc30e'
$url64 = 'https://github.com/godotengine/godot-builds/releases/download/4.2-beta2/Godot_v4.2-beta2_win64.exe.zip'
$checksum64 = '5406da75237aa31b4a37a40f5e4e2c552d5494736f957fa14d254cca328dd8e7'
# $env:ChocolateyPackageName
Install-ChocolateyZipPackage `
  -PackageName "$packageName" `
  -Url $url `
  -UnzipLocation "$toolsDir" `
  -Url64bit "$url64" `
  -Checksum "$checksum" `
  -ChecksumType "sha256" `
  -Checksum64 "$checksum64" `
  -ChecksumType64 "sha256"