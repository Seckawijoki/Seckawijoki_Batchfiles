@echo off

set fileApkName=app-demo-debug
set suffixApk=apk

set fileApk=%fileApkName%.%suffixApk%

set pathApk=F:\Android_Studio_projects\Seckawijoki_ANDROID_TEST\app\build\outputs\apk\demo\debug\%fileApk%

set fileZipCopied=app-demo-debug.zip
set dirUnzip=app-demo-debug

copy %pathApk% %fileZipCopied%
unzip %fileZipCopied% -d %dirUnzip%
