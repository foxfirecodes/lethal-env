#!/bin/bash

if [ -d dev/BepInEx ]; then
  cd dev
elif [ ! -d BepInEx ]; then
  echo "failed to find BepInEx directory. please run this command from inside your dev env" >&1
  exit 1
fi

url="${1?missing url}"
download_zip="$(mktemp)"
download_folder="$(mktemp -d)"

echo "downloading $url"
curl --progress-bar -L "$url" -o "$download_zip"
unzip -q "$download_zip" -d "$download_folder"

mv "$download_folder"/*.dll ./dev/BepInEx/plugins/ 2>/dev/null || true
mv "$download_folder"/plugins/* ./dev/BepInEx/plugins/ 2>/dev/null || true
mv "$download_folder"/BepInEx/plugins/* ./dev/BepInEx/plugins/ 2>/dev/null || true

mv "$download_folder"/*.cfg ./dev/BepInEx/config/ 2>/dev/null || true
mv "$download_folder"/config/* ./dev/BepInEx/config/ 2>/dev/null || true
mv "$download_folder"/BepInEx/config/* ./dev/BepInEx/config/ 2>/dev/null || true
