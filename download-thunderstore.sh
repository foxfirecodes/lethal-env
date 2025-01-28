#!/bin/bash

url="${1?missing url}"
download_zip="$(mktemp)"
download_folder="$(mktemp -d)"

echo "downloading $url"
curl --progress-bar -L "$url" -o "$download_zip"
unzip -q "$download_zip" -d "$download_folder"

if [ -d "$download_folder"/plugins ]; then
  echo "moving plugins/*"
  mv "$download_folder"/plugins/* ./dev/BepInEx/plugins/
fi
if [ -d "$download_folder"/config ]; then
  echo "moving config/*"
  mv "$download_folder"/config/* ./dev/BepInEx/plugins/
fi
if [ -d "$download_folder"/BepInEx/plugins ]; then
  echo "moving BepInEx/plugins/*"
  mv "$download_folder"/BepInEx/plugins/* ./dev/BepInEx/plugins/
fi
if [ -d "$download_folder"/BepInEx/config ]; then
  echo "moving BepInEx/config/*"
  mv "$download_folder"/BepInEx/config/* ./dev/BepInEx/config/
fi
