@echo off

set mApkVersionName=0.27.0

set fileClientManagerCpp=ClientManager.cpp
call copy_ClientManager_cpp.bat
set fileWritten=ClientManager_written_by_java.cpp
copy  %fileClientManagerCpp% %fileWritten%

set javaFile=ChangeClientManagerCpp

javac %javaFile%.java
java %javaFile% %fileClientManagerCpp% %fileWritten% %mApkVersionName%

del /q %javaFile%.class