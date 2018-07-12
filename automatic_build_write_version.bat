@echo off

echo ---------- write version to ClientManager.cpp ----------
cd %PATH_IWORLD%

set javaFileChangeClientManagerCpp=ChangeClientManagerCpp
set fileClientManagerCpp=ClientManager.cpp
set fileWritten=ClientManager_written_by_java.cpp

copy  %fileClientManagerCpp% %fileWritten%
copy %PATH_AUTOMATIC_BUILD%\%javaFileChangeClientManagerCpp%.java %javaFileChangeClientManagerCpp%.java

javac %javaFileChangeClientManagerCpp%.java
java %javaFileChangeClientManagerCpp% %fileClientManagerCpp% %fileWritten% %mApkVersionName%

copy %fileWritten% %fileClientManagerCpp%

del /q %fileWritten%
del /q %javaFileChangeClientManagerCpp%.java
del /q %javaFileChangeClientManagerCpp%.class

echo ---------- write version to AndroidManifest.xml ----------
cd %mPathCurrentProjAndroid%

set javaFileChangeAndroidManifestXml=ChangeAndroidManifestXml
set fileAndroidManifestXml=AndroidManifest.xml
set fileWritten=AndroidManifest_written_by_java.xml

copy  %fileAndroidManifestXml% %fileWritten%
copy %PATH_AUTOMATIC_BUILD%\%javaFileChangeAndroidManifestXml%.java %javaFileChangeAndroidManifestXml%.java

javac %javaFileChangeAndroidManifestXml%.java
java %javaFileChangeAndroidManifestXml% %fileAndroidManifestXml% %fileWritten% %mApkVersionName%

copy %fileWritten% %fileAndroidManifestXml%

del /q %fileWritten%
del /q %javaFileChangeAndroidManifestXml%.java
del /q %javaFileChangeAndroidManifestXml%.class