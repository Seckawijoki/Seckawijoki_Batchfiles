@echo off
setlocal EnableDelayedExpansion
echo ---------- build all channels start ----------
set mStartTimeAllChannels=%time%

set mDirCurrentProjAndroid=%DIR_PROJ_ANDROID%
set mPathCurrentProjAndroid=%PATH_APP_PLAY%\%DIR_PROJ_ANDROID%
set mPathProjAndroidNdkBuild=%mPathCurrentProjAndroid%

echo ----- all channels ndk build start -----
set mStartTimeAllChannelsNdkBuild=%time%
call %PATH_AUTOMATIC_BUILD%\%batchNdkBuild%
call %PATH_AUTOMATIC_BUILD%\%batchCopySoFilesToLibs%
call %PATH_AUTOMATIC_BUILD%\%batchBackupSoFiles%

for %%i in (%A_DIRS_PROJ_ANDROID_ALL%) do (
  set mDirCurrentProjAndroid=%%i
  set mPathCurrentProjAndroid=%PATH_APP_PLAY%\!mDirCurrentProjAndroid!
  if not exist !mPathCurrentProjAndroid!\libs mkdir !mPathCurrentProjAndroid!\libs
  if not exist !mPathCurrentProjAndroid!\libs\%mNdkBuildAbi% mkdir !mPathCurrentProjAndroid!\libs\%mNdkBuildAbi%
  copy %mPathProjAndroidNdkBuild%\%DIR_NDK_BUILD_OUT%\%mNdkBuildAbi%\* !mPathCurrentProjAndroid!\libs\%mNdkBuildAbi%\ 
  echo all channels: copy so files to !mDirCurrentProjAndroid!
)

set mEndTimeAllChannelsNdkBuild=%time%
echo ----- all channels ndk build end -----