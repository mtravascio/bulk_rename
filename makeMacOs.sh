#!/bin/bash

BUILD_DIR="./build/macos"

rm -rf "$BUILD_DIR"/*

dart pub get
dart compile exe ./bin/spegniti.dart -o "$BUILD_DIR"/spegniti -S /dev/null
