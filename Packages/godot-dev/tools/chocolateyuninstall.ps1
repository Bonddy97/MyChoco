$ErrorActionPreference = "Stop";

$packageName = "Godot-dev"
$unzipLocation = Join-Path ([Environment]::GetFolderPath("LocalApplicationData")) $packageName

# Delete shortcuts
$godot = Get-ChildItem -Path $unzipLocation -Recurse | Where-Object { $_.Name -match "Godot.*\.exe$" -and $_.Name -notmatch "console" } | Select-Object -ExpandProperty FullName | Select-Object -First 1
$godot_console = Get-ChildItem -Path $unzipLocation -Recurse | Where-Object { $_.Name -match "Godot.*console\.exe$" } | Select-Object -ExpandProperty FullName | Select-Object -First 1

@(
  , @('Godot.dev', $godot)
  , @('Godot.console.dev', $godot_console)
) | ForEach-Object {
  # Remove Programs shortcuts
  $shortcutPath = Join-Path ([Environment]::GetFolderPath("Programs")) "$($_[0]).lnk"
  Remove-Item -Path $shortcutPath -ErrorAction SilentlyContinue

  # Remove Desktop shortcuts
  $shortcutPath = Join-Path ([Environment]::GetFolderPath("Desktop")) "$($_[0]).lnk"
  Remove-Item -Path $shortcutPath -ErrorAction SilentlyContinue
}

if (Test-Path $unzipLocation) {
  Remove-Item -Path $unzipLocation -Recurse -Force -ErrorAction SilentlyContinue
}

