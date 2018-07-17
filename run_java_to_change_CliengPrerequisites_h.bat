@echo off

set fileClientPrerequisitesH=ClientPrerequisites.h
call copy_ClientPrerequisites_h.bat
set fileWritten=ClientPrerequisites_written_by_java.h
copy  %fileClientPrerequisitesH% %fileWritten%

set javaFile=WriteProjectVersion

javac %javaFile%.java
java %javaFile% %fileClientPrerequisitesH% %fileWritten% %mApkVersionName% 2 true GBK GBK

del /q *.class