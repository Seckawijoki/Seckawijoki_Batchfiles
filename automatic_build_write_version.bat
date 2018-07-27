@echo off

set changeAndroidManifestXml=0
set changeClientManagerCpp=1
set changeClientPrerequisitesH=2

set javaWritePojectVersion=WriteProjectVersion
set fileWritten=project_file_written_by_java

echo ---------- write version to AndroidManifest.xml ----------
cd %mPathCurrentProjAndroid%

set fileRead=AndroidManifest.xml

copy  %fileRead% %fileWritten%
copy %PATH_AUTOMATIC_BUILD%\%DIR_SUB_FILES%\%javaWritePojectVersion%.java %javaWritePojectVersion%.java

javac %javaWritePojectVersion%.java
java %javaWritePojectVersion% %fileRead% %fileWritten% %changeAndroidManifestXml% %mApkVersionName% UTF-8 UTF-8

copy %fileWritten% %fileRead%
del /q %fileWritten%
del /q %javaWritePojectVersion%.java
del /q *.class

echo ---------- write version to ClientManager.cpp ----------
cd %PATH_IWORLD%

set fileRead=ClientManager.cpp

copy  %fileRead% %fileWritten%
copy %PATH_AUTOMATIC_BUILD%\%DIR_SUB_FILES%\%javaWritePojectVersion%.java %javaWritePojectVersion%.java

javac %javaWritePojectVersion%.java
java %javaWritePojectVersion% %fileRead% %fileWritten% %changeClientManagerCpp% %mApkVersionName%  GB2312 GB2312

copy %fileWritten% %fileRead%
del /q %fileWritten%
del /q %javaWritePojectVersion%.java
del /q *.class

if defined mRelease if "%mRelease%" == "true" (
  echo ---------- annotate "#define IWORLD_DEV_BUILD" in ClientPrerequisites.h ----------
  cd %PATH_IWORLD%

  set fileRead=ClientPrerequisites.h

  copy  %fileRead% %fileWritten%
  copy %PATH_AUTOMATIC_BUILD%\%DIR_SUB_FILES%\%javaWritePojectVersion%.java %javaWritePojectVersion%.java

  javac %javaWritePojectVersion%.java
  java %javaWritePojectVersion% %fileRead% %fileWritten% %changeClientPrerequisitesH% true  GB2312 GB2312
  copy %fileWritten% %fileRead%
)

del /q %fileWritten%
del /q %javaWritePojectVersion%.java
del /q *.class