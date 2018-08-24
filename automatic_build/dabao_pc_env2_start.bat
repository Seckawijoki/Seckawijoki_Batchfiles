@echo off
set PATH_AUTOMATIC_BUILD=%~dp0
rem 修改以下参数，以便在您的电脑上执行
rem 1.工作目录
set DIR_TRUNK=work
rem 2.环境文件夹env目录
set DIR_ENV_1=env2
rem 3.NDK编译工具ndk_build.cmd的目录
set mPathNdkBuildCmd=d:\android-ndk-r10d
rem 4.NDK编译类型，可默认指定armeabi
set mNdkBuildAbi=armeabi
rem 5.版本号
set mApkVersionName=0.27.4
rem 6.参考《自动化构建参数说明.txt》
set automaticBuildType=1
rem 7.Android项目的文件夹名
set mDirCurrentProjAndroid=Proj.Android.Mini

REM set mRemainPreviousSoFiles=1
REM set mRemainPreviousAssets=1
REM set mDebugEcho=1

%PATH_AUTOMATIC_BUILD%\automatic_build_entrance.bat %DIR_TRUNK% %DIR_ENV_1% %mPathNdkBuildCmd%  %mNdkBuildAbi% %mApkVersionName%  %automaticBuildType% %mDirCurrentProjAndroid%