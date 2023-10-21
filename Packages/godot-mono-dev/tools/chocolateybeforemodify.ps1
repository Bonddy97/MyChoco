$ErrorActionPreference = "Stop";

# Stop-Process won't error if the process doesn't exist
Get-Process "Godot Engine" -ErrorAction SilentlyContinue | Stop-Process -ErrorAction Stop
