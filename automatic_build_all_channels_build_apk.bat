@echo off
setlocal EnableDelayedExpansion
echo ---------- build all channels start ----------

set mDirCurrentProjAndroid=%DIR_PROJ_ANDROID%
set mPathCurrentProjAndroid=%PATH_APP_PLAY%\%DIR_PROJ_ANDROID%
set mPathProjAndroidNdkBuild=%mPathCurrentProjAndroid%

echo ----- all channels build apk start -----
set mStartTimeAllChannelsBuildApk=%time%
for %%i in (%A_DIRS_PROJ_ANDROID_ALL%) do (
  set mDirCurrentProjAndroid=%%i
  set mPathCurrentProjAndroid=%PATH_APP_PLAY%\!mDirCurrentProjAndroid!
  call %PATH_AUTOMATIC_BUILD%\%batchWriteVersion%
  call %PATH_AUTOMATIC_BUILD%\%batchBuildApk%
  echo all channels: build !mDirCurrentProjAndroid! apk
  if defined mDebugPause pause
)
set mEndTimeAllChannelsBuildApk=%time%
echo ----- all channels build apk end -----

set mEndTimeAllChannels=%time%
echo ---------- build all channels end ----------