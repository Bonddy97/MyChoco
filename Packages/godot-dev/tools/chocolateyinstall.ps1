# Godot_v$version_$arch.zip
# └── Godot_v$version_$arch.exe
# └── Godot_v$version_$arch_console.exe
  
# Release URL: https://github.com/godotengine/godot-builds/releases
# And in this package, I just pick the pre-release.
#$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packageName = "Godot-dev"
# For win32
$url = 'https://github.com/godotengine/godot-builds/releases/download/4.1.3-rc1/Godot_v4.1.3-rc1_win32.exe.zip'
$checksum = 'b45d934f974c8d78e146223ffaf2f72cdadaf2cce54f1db173c75ef930db497d'
# For win64
$url64 = 'https://github.com/godotengine/godot-builds/releases/download/4.1.3-rc1/Godot_v4.1.3-rc1_win64.exe.zip'
$checksum64 = '1f83ceaf86df1d636bba49a1c4c54a91dee831de16fcc27351596a8f906fe9a8'
# Define unizip location.
$unzipLocation = Join-Path ([Environment]::GetFolderPath("LocalApplicationData")) $packageName

$packageArgs = @{
  packageName    = $packageName
  fileType       = "ZIP"
  # For win32
  url            = $url
  checksum       = $checksum
  checksumType   = "sha256"
  # For win64
  url64          = $url64
  checksum64     = $checksum64
  checksumType64 = "sha256"
  # Unzip location
  unzipLocation  = $unzipLocation
}


# Install the zip package
Install-ChocolateyZipPackage @packageArgs

# Get the unzip folder
$folder = Get-ChildItem -Path $unzipLocation -Directory | Where-Object { $_.Name -like "Godot*" } | Select-Object -First 1
if ($folder) {
  # Copy conetnt to the unzip location
  Copy-Item -Path "$($folder.FullName)\\*" -Destination $unzipLocation -Recurse -Force
  # Remove unzip folder
  Remove-Item -Path $folder.FullName -Recurse -Force
}
else {
  Write-Output "No unzip folder found!"
}

# Create shortcuts
$godot = Get-ChildItem -Path $unzipLocation -Recurse | Where-Object { $_.Name -match "Godot.*\.exe$" -and $_.Name -notmatch "console" } | Select-Object -ExpandProperty FullName | Select-Object -First 1
$godot_console = Get-ChildItem -Path $unzipLocation -Recurse | Where-Object { $_.Name -match "Godot.*console\.exe$" } | Select-Object -ExpandProperty FullName | Select-Object -First 1

@(
    , @('Godot.dev', $godot)
    , @('Godot.console.dev', $godot_console)
) | ForEach-Object {
    # Create Programs shortcuts
    $programsShortcutPath = Join-Path ([Environment]::GetFolderPath("Programs")) "$($_[0]).lnk"
    Install-ChocolateyShortcut -ShortcutFilePath $programsShortcutPath -Target $_[1] -WorkingDirectory $unzipLocation

    # Create Desktop shortcuts
    $desktopShortcutPath = Join-Path ([Environment]::GetFolderPath("Desktop")) "$($_[0]).lnk"
    Install-ChocolateyShortcut -ShortcutFilePath $desktopShortcutPath -Target $_[1] -WorkingDirectory $unzipLocation
}
