@echo off
set PATH_AUTOMATIC_BUILD=%~dp0
set DIR_TRUNK=trunk
set DIR_ENV_1=env2
set mPathNdkBuildCmd=d:\android-ndk-r10d
set mNdkBuildAbi=armeabi
set mApkVersionName=0.27.4
set automaticBuildType=13
set mDirCurrentProjAndroid=Proj.Android.Mini

REM set mRemainPreviousSoFiles=1
REM set mRemainPreviousAssets=1
rem set mDebugEcho=1

call %PATH_AUTOMATIC_BUILD%\automatic_build_entrance.bat %DIR_TRUNK% %DIR_ENV_1% %mPathNdkBuildCmd%  %mNdkBuildAbi% %mApkVersionName%  %automaticBuildType% %mDirCurrentProjAndroid%