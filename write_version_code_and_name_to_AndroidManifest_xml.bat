@echo off
setlocal EnableDelayedExpansion
set VERSION_CODE=%random%
set VERSION_NAME=%random%.%random%.%random%
set ANDROID_MANIFEST_XML_FILE=AndroidManifest.xml
if not exist %ANDROID_MANIFEST_XML_FILE% (
  copy f:\Miniworld_projects\client\AppPlay\proj.Android.MiniBeta\%ANDROID_MANIFEST_XML_FILE% .\%ANDROID_MANIFEST_XML_FILE%
)
set WRITTEN_FILE=written_AndroidManifest.xml
copy %ANDROID_MANIFEST_XML_FILE% %WRITTEN_FILE%
find "android:version" %WRITTEN_FILE%
echo %VERSION_CODE%
echo %VERSION_NAME%
