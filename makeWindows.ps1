$buildir=".\build\windows"
$buildfiles="$buildir\*"

if (-not (Test-Path $buildir)) {
	New-Item -ItemType Directory -Path $buildir
} else {
	Remove-Item $buildfiles -Force
}

dart pub get
dart compile exe .\bin\spegniti.dart -o $buildir\spegniti.exe -S spegniti.dbg
