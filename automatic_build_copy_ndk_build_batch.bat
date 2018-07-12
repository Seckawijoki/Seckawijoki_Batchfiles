@echo off

set batchFile=ndk_build.bat

%DRIVE%
cd %mPathCurrentProjAndroid%
echo @echo off > %batchFile%
REM echo set PATH_AUTOMATIC_BUILD=%PATH_AUTOMATIC_BUILD% >> %batchFile%
REM echo set DIR_TRUNK=%DIR_TRUNK% >> %batchFile%
REM echo set DIR_ENV_1=%DIR_ENV_1% >> %batchFile%
REM echo set mPathNdkBuildCmd=%mPathNdkBuildCmd% >> %batchFile%
REM echo set mNdkBuildApi=%mNdkBuildApi% >> %batchFile%
REM echo set mVersionName=%mVersionName% >> %batchFile%
REM echo set mDirCurrentProjAndroid=%mDirCurrentProjAndroid% >> %batchFile%
echo %PATH_AUTOMATIC_BUILD%\automatic_build_entrance.bat %DIR_TRUNK% %DIR_ENV_1% %mPathNdkBuildCmd% %mNdkBuildApi% %mVersionName% 2 %mDirCurrentProjAndroid% >> %batchFile%
if defined DEBUG_ECHO echo That copy ndk_build.bat to %mDirCurrentProjAndroid% has completed.