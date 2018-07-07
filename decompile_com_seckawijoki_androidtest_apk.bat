@echo off

set projectName=com.seckawijoki.androidtest
set suffixApk=apk
set suffixZip=zip
set fileApkName=app-demo-debug
set fileApk=%fileApkName%.%suffixApk%
set fileZip=%fileApkName%.%suffixZip%
set fileDexClasses=classes.dex
set fileJarDecompiled=%projectName%-dex2jar.jar
set dirUnzip=%fileApkName%
set dirDecompiledJarFiles=decompiled_jar_files
set pathApk=F:\Android_Studio_projects\Seckawijoki_ANDROID_TEST\app\build\outputs\apk\demo\debug\%fileApk%

copy %pathApk% .\%fileZip%
unzip %fileZip% -d %dirUnzip%
if not exist %dirDecompiledJarFiles% mkdir %dirDecompiledJarFiles%
echo A | d2j-dex2jar %dirUnzip%\%fileDexClasses% --force --output %dirDecompiledJarFiles%\%fileJarDecompiled%
rd /s /q %dirUnzip%
del /q %fileZip%
