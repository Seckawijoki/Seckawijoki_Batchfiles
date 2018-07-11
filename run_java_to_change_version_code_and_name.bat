@echo off

set versionName=0.27.0

set fileAndroidManifestXml=AndroidManifest.xml
call copy_AndroidManifest_xml.bat
set fileWritten=AndroidManifest_written_by_java.xml
copy  %fileAndroidManifestXml% %fileWritten%

set javaFile=ChangeVersionCodeAndName

javac %javaFile%.java
java %javaFile% %fileAndroidManifestXml% %fileWritten% %versionName%