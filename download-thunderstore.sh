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

find "$download_folder" -name '*.dll' -exec mv {} ./BepInEx/plugins/ \;
find "$download_folder" -name '*.cfg' -exec mv {} ./BepInEx/config/ \;
