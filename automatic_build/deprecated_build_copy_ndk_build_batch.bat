@echo off

%DRIVE%
cd %mPathCurrentProjAndroid%
echo @echo off > %BATCH_NDK_BUILD%
REM echo set PATH_AUTOMATIC_BUILD=%PATH_AUTOMATIC_BUILD% >> %batchFile%
REM echo set DIR_TRUNK=%DIR_TRUNK% >> %batchFile%
REM echo set DIR_ENV_1=%DIR_ENV_1% >> %batchFile%
REM echo set mPathNdkBuildCmd=%mPathNdkBuildCmd% >> %batchFile%
REM echo set mNdkBuildAbi=%mNdkBuildAbi% >> %batchFile%
REM echo set mVersionName=%mVersionName% >> %batchFile%
REM echo set mDirCurrentProjAndroid=%mDirCurrentProjAndroid% >> %batchFile%
echo %PATH_AUTOMATIC_BUILD%\automatic_build_entrance.bat %DIR_TRUNK% %DIR_ENV_1% %mPathNdkBuildCmd% %mNdkBuildAbi% %mApkVersionName% %AUTOMATIC_BUILD_NDK_BUILD% %mDirCurrentProjAndroid% >> %BATCH_NDK_BUILD%
rem echo That copy manual script of ndk build to %mDirCurrentProjAndroid% has completed.
echo 生成文件：%mPathCurrentProjAndroid%\%BATCH_NDK_BUILD%