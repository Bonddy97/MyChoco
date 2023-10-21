import requests
import re
import os
import hashlib

# Base infos.
releases = 'https://api.github.com/repos/godotengine/godot-builds/releases'
script_path = './tools/chocolateyinstall.ps1'
nuspec_file = './godot-dev.nuspec'

# Get the file checksum
def get_checksum(url):
    response = requests.get(url, stream=True)
    response.raise_for_status()

    hash_sha256 = hashlib.sha256()
    for chunk in response.iter_content(chunk_size=4096):
        hash_sha256.update(chunk)

    return hash_sha256.hexdigest()


# Get latest pre-release infos
def get_latest():
    response = requests.get(releases)
    json = response.json()

    re_32  = "Godot_v.+_win32.exe"
    re_64  = "Godot_v.+_win64.exe"

    for release in json:
        if not release['prerelease']:
            continue
        asset32 = next((asset for asset in release['assets'] if re.match(re_32, asset['name'])), None)
        asset64 = next((asset for asset in release['assets'] if re.match(re_64, asset['name'])), None)
        if asset32 is None or asset64 is None:
            continue
        url32 = asset32['browser_download_url']
        url64 = asset64['browser_download_url']
        version = release['tag_name'].replace('v','')

        return {'URL32': url32, 'URL64': url64, 'Version': version}

    raise Exception("No release with suitable binaries found.")

# Modify the update info about the packages.
def update_package(script_path, nuspec_file, latest):
    # Modify tools/chocolateyinstall.ps1
    with open(script_path, 'r+') as script_file:
        script = script_file.read()

        script_replacements = {
            r"(^[$]url\s*=\s*)('.*')": f"\\1'{latest['URL32']}'",
            r"(^[$]checksum\s*=\s*)('.*')": f"\\1'{latest['Checksum32']}'",
            r"(^[$]url64\s*=\s*)('.*')": f"\\1'{latest['URL64']}'",
            r"(^[$]checksum64\s*=\s*)('.*')": f"\\1'{latest['Checksum64']}'"
        }

        for pattern, replacement in script_replacements.items():
            script = re.sub(pattern, replacement, script, flags=re.MULTILINE)

        print("---------------------------------------------------------------------")
        print(script)
        print("---------------------------------------------------------------------")

        script_file.seek(0)
        script_file.write(script)
        script_file.truncate()

    # Modify godot-mono-dev.nuspec
    with open(nuspec_file, 'r+') as nuspec_file:
        nuspec = nuspec_file.read()

        version_pattern = r"<version>[^<]+</version>"
        version_replacement = f"<version>{latest['Version']}</version>"
        nuspec = re.sub(version_pattern, version_replacement, nuspec)

        print("---------------------------------------------------------------------")
        print(nuspec)
        print("---------------------------------------------------------------------")

        nuspec_file.seek(0)
        nuspec_file.write(nuspec)
        nuspec_file.truncate()

# Get the info choco needed.
latest_release = get_latest()
latest_release['Checksum32'] = get_checksum(latest_release['URL32'])
latest_release['Checksum64'] = get_checksum(latest_release['URL64'])

# Update files.
update_package(os.path.join(os.getcwd(), script_path), os.path.join(os.getcwd(), nuspec_file), latest_release)
