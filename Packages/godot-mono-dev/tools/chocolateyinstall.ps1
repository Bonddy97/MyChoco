$ErrorActionPreference = 'Stop'

# Godot_v$version_mono_$arch.zip
# └── Godot_v$version_mono_$arch.exe
# └── Godot_v$version_mono_$arch_console.exe
# └── GodotSharp

# Release URL: https://github.com/godotengine/godot-builds/releases
# And in this package, I just pick the pre-release.
#$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packageName = "Godot-mono-dev"
# For win32
$url = 'https://github.com/godotengine/godot-builds/releases/download/4.6-dev3/Godot_v4.6-dev3_mono_win32.zip'
$checksum = 'f5b7193830fbbcbc2afb6cca7f3c84752339cd48d60df5a0199ee2df782066ea'
# For win64
$url64 = 'https://github.com/godotengine/godot-builds/releases/download/4.6-dev3/Godot_v4.6-dev3_mono_win64.zip'
$checksum64 = '7d34a040da26fb7e2dc7bae69fbba5a1e7ac34d1ba6f99baac503fb6424320af'
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
    , @('Godot(mono).dev', $godot)
    , @('Godot(mono).console.dev', $godot_console)
) | ForEach-Object {
    # Create Programs shortcuts
    $programsShortcutPath = Join-Path ([Environment]::GetFolderPath("Programs")) "$($_[0]).lnk"
    Install-ChocolateyShortcut -ShortcutFilePath $programsShortcutPath -Target $_[1] -WorkingDirectory $unzipLocation

    # Create Desktop shortcuts
    $desktopShortcutPath = Join-Path ([Environment]::GetFolderPath("Desktop")) "$($_[0]).lnk"
    Install-ChocolateyShortcut -ShortcutFilePath $desktopShortcutPath -Target $_[1] -WorkingDirectory $unzipLocation
}
