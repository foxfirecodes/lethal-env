#!/bin/bash

set -ex

if [ -d dev ]; then
  echo "dev directory already exists" >&1
  exit 1
fi

lethal_exe_path=$(protontricks --cwd-app -c 'realpath "Lethal Company.exe"' 1966720 2>/dev/null)

if [ -z "$lethal_exe_path" ]; then
  echo "failed to detect lethal company path" >&1
  exit 1
fi

echo "found lethal company exe: $lethal_exe_path"


download_path="/tmp/bepinex.zip"
if [ -f "$download_path" ]; then
  echo "BepInEx already downloaded, skipping..."
else
  echo "downloading BepInEx"
  curl -L https://github.com/BepInEx/BepInEx/releases/download/v5.4.22/BepInEx_x64_5.4.22.0.zip -o "$download_path"
fi

echo "setting up dev dir"

mkdir -p dev
unzip -q "$download_path" -d dev

echo "creating start.sh"
# Create start.sh script
cat > dev/start.sh << EOF
#!/bin/bash
cd "\$(dirname "\$0")"
protontricks-launch --appid 1966720 "$lethal_exe_path" --doorstop-enable true \\
--doorstop-target "Z:\$(realpath ./BepInEx/core/BepInEx.Preloader.dll)"
EOF
chmod +x dev/start.sh


echo "downloading mods"

mkdir dev/BepInEx/plugins
mkdir dev/BepInEx/config

"$(dirname "$0")"/download-thunderstore.sh https://thunderstore.io/package/download/megumin/LethalDevMode/1.0.0/
"$(dirname "$0")"/download-thunderstore.sh https://thunderstore.io/package/download/CTNOriginals/DevelopmentStartup/1.2.0/

echo "setup complete! run dev/start.sh to start the game with BepInEx"
