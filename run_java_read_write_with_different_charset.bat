@echo off

set mApkVersionName=0.27.3
set charsetGK2312=GK2312
set charsetGBK=GBK
set charsetUTF8=UTF-8

set fileAndroidManifestXml=AndroidManifest.xml
call copy_AndroidManifest_xml.bat
set javaFile=ChangeAndroidManifestXml
javac %javaFile%.java

set readCharset=%charsetGBK%
set writeCharset=%charsetGBK%
set fileWritten=AndroidManifest_read_%readCharset%_write_%writeCharset%.xml
copy  %fileAndroidManifestXml% %fileWritten%
java %javaFile% %fileAndroidManifestXml% %fileWritten% %mApkVersionName% %readCharset% %writeCharset%

set readCharset=%charsetGBK%
set writeCharset=%charsetUTF8%
set fileWritten=AndroidManifest_read_%readCharset%_write_%writeCharset%.xml
copy  %fileAndroidManifestXml% %fileWritten%
java %javaFile% %fileAndroidManifestXml% %fileWritten% %mApkVersionName% %readCharset% %writeCharset%

set readCharset=%charsetUTF8%
set writeCharset=%charsetGBK%
set fileWritten=AndroidManifest_read_%readCharset%_write_%writeCharset%.xml
copy  %fileAndroidManifestXml% %fileWritten%
java %javaFile% %fileAndroidManifestXml% %fileWritten% %mApkVersionName% %readCharset% %writeCharset%

set readCharset=%charsetUTF8%
set writeCharset=%charsetUTF8%
set fileWritten=AndroidManifest_read_%readCharset%_write_%writeCharset%.xml
copy  %fileAndroidManifestXml% %fileWritten%
java %javaFile% %fileAndroidManifestXml% %fileWritten% %mApkVersionName% %readCharset% %writeCharset%

del /q %javaFile%.class