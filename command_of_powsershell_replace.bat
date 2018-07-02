@echo off
call copy_android_manifest_xml.bat
set replaced_file=replaced_AndroidManifest.xml
copy AndroidManifest.xml %replaced_file%
powershell -Command "(gc %replaced_file%) -replace 'android', 'anzhuo' | Out-File %replaced_file%"
type %replaced_file%
powershell -Command "(gc %replaced_file%) -replace 'anzhuo', 'android' | Out-File %replaced_file%"