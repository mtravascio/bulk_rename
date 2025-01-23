#!/bin/bash

BUILD_DIR="./build/linux"

mkdir -p "$BUILD_DIR"
rm -rf "$BUILD_DIR"/*

dart pub get
dart compile exe ./bin/bulk_rename.dart -o "$BUILD_DIR"/bulk_rename -S /dev/null
