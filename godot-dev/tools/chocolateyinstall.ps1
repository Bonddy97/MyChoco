$ErrorActionPreference = 'Stop' # stop on all errors
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url = 'https://github.com/godotengine/godot-builds/releases/download/4.2-dev6/Godot_v4.2-dev6_win32.exe.zip'
$checksum = '3e42c6d3483d8092d6095156dbee999eee3e427fb15eaa99747053cc313036b7'
$url64 = 'https://github.com/godotengine/godot-builds/releases/download/4.2-dev6/Godot_v4.2-dev6_win64.exe.zip'
$checksum64 = 'b8ef015338dd5f11e83d259a1dae508b54f41154a68f7a5771ce966924102574'
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