@echo off
call copy_android_manifest_xml.bat
set FILE_REPLACED=replaced_AndroidManifest.xml
copy /y AndroidManifest.xml %FILE_REPLACED%
powershell -Command "(gc %FILE_REPLACED%) -replace 'android', 'anzhuo' | Out-File %FILE_REPLACED%"
type %FILE_REPLACED%