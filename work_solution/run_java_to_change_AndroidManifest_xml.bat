@echo off

set mApkVersionName=0.27.3

set fileAndroidManifestXml=AndroidManifest.xml
call copy_AndroidManifest_xml.bat
set fileWritten=AndroidManifest_written_by_java.xml
copy  %fileAndroidManifestXml% %fileWritten%

set javaFile=ChangeAndroidManifestXml

javac %javaFile%.java
java %javaFile% %fileAndroidManifestXml% %fileWritten% %mApkVersionName%

copy %fileWritten% %fileAndroidManifestXml%
del /q %javaFile%.class