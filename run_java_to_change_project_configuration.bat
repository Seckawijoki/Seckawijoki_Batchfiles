@echo off

set javaFile=WriteProjectVersion
javac %javaFile%.java
set fileWritten=project_file_written_by_java

set versionName=0.27.3

set fileRead=ClientPrerequisites.h
call copy_ClientPrerequisites_h.bat
copy  %fileRead% %fileWritten%
java %javaFile% %fileRead% %fileWritten% %mApkVersionName% 2 true GBK GBK
copy %fileWritten% %fileRead%

set fileRead=ClientManager.cpp
call copy_ClientManager_cpp.bat
copy  %fileRead% %fileWritten%
java %javaFile% %fileRead% %fileWritten% %mApkVersionName% 1 %versionName% GBK GBK
copy %fileWritten% %fileRead%

set fileRead=AndroidManifest.xml
call copy_AndroidManifest_xml.bat
copy  %fileRead% %fileWritten%
java %javaFile% %fileRead% %fileWritten% %mApkVersionName% 0 %versionName% GBK GBK
copy %fileWritten% %fileRead%

del %fileWritten%
del /q *.class