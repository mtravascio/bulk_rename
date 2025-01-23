$buildir=".\build\windows"
$buildfiles="$buildir\*"

if (-not (Test-Path $buildir)) {
	New-Item -ItemType Directory -Path $buildir
}# else {
#	Remove-Item $buildfiles -Force
#}

fvm dart pub get
fvm dart compile exe .\bin\bulk_rename.dart -o $buildir\bulk_rename.exe -S bulk_rename.dbg
