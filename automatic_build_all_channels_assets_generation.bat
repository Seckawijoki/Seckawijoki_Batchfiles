@echo off
setlocal EnableDelayedExpansion
set mStartTimeAllChannelsAssetsGeneration=%time%
echo ----- all channels assets generation start -----

echo ----- all channels assets generation apk load 0 start -----
set startTimeApkLoad0=%time%
set mApkLoad=%APK_LOAD_NONE%
set mDirCurrentProjAndroid=!DIR_PROJ_ANDROID_BLOCKARK!
set mPathCurrentProjAndroid=%PATH_APP_PLAY%\!mDirCurrentProjAndroid!
set mPathProjAndroidAssetsIntegration=!mPathCurrentProjAndroid!
call %PATH_AUTOMATIC_BUILD%\%batchAssetsIntegrationBefore%
call %PATH_AUTOMATIC_BUILD%\%batchAssetsIntegration%
call %PATH_AUTOMATIC_BUILD%\%batchAssetsIntegrationAfter%
call %PATH_AUTOMATIC_BUILD%\%batchAssetsConfusion%
call %PATH_AUTOMATIC_BUILD%\%batchBackupAssets%
for %%i in (!A_DIRS_PROJ_ANDROID_APK_LOAD_0!) do (
  if not "%%i" == "!DIR_PROJ_ANDROID_BLOCKARK!" (
    set mDirCurrentProjAndroid=%%i
    set mPathCurrentProjAndroid=%PATH_APP_PLAY%\!mDirCurrentProjAndroid!
    call %PATH_AUTOMATIC_BUILD%\%batchAssetsIntegrationBefore%
    echo ----- copy assets to !mDirCurrentProjAndroid! start -----
    echo a | xcopy /s /e /a /c /q !mPathProjAndroidAssetsIntegration!\%DIR_ASSETS%\* !mPathCurrentProjAndroid!\%DIR_ASSETS%\
    call %PATH_AUTOMATIC_BUILD%\%batchAssetsIntegrationAfter%
    echo ----- copy assets to !mDirCurrentProjAndroid! end -----
  )
)
set endTimeApkLoad0=%time%
echo ----- all channels assets generation apk load 0 end -----
if defined mDebugPause pause

echo ----- all channels assets generation apk load 1 start -----
set startTimeApkLoad1=%time%
set mApkLoad=%APK_LOAD_DISTRIBUTED_DOWNLOAD%
set mDirCurrentProjAndroid=%DIR_PROJ_ANDROID_MINI%
set mPathCurrentProjAndroid=%PATH_APP_PLAY%\!mDirCurrentProjAndroid!
set mPathProjAndroidAssetsIntegration=!mPathCurrentProjAndroid!
call %PATH_AUTOMATIC_BUILD%\%batchAssetsIntegrationBefore%
call %PATH_AUTOMATIC_BUILD%\%batchAssetsIntegration%
call %PATH_AUTOMATIC_BUILD%\%batchAssetsIntegrationAfter%
call %PATH_AUTOMATIC_BUILD%\%batchAssetsConfusion%
call %PATH_AUTOMATIC_BUILD%\%batchBackupAssets%
for %%i in (!A_DIRS_PROJ_ANDROID_APK_LOAD_1!) do (
  if not "%%i" == "!DIR_PROJ_ANDROID_MINI!" (
    set mDirCurrentProjAndroid=%%i
    set mPathCurrentProjAndroid=%PATH_APP_PLAY%\!mDirCurrentProjAndroid!
    call %PATH_AUTOMATIC_BUILD%\%batchAssetsIntegrationBefore%
    echo ----- copy assets to !mDirCurrentProjAndroid! start -----
    echo a | xcopy /s /e /a /c /q !mPathProjAndroidAssetsIntegration!\%DIR_ASSETS%\* !mPathCurrentProjAndroid!\%DIR_ASSETS%\
    call %PATH_AUTOMATIC_BUILD%\%batchAssetsIntegrationAfter%
    echo ----- copy assets to !mDirCurrentProjAndroid! end -----
  )
)
set endTimeApkLoad1=%time%
echo ----- all channels assets generation apk load 1 end -----
if defined mDebugPause pause

echo ----- all channels assets generation apk load 2 start -----
set startTimeApkLoad2=%time%
set mApkLoad=%APK_LOAD_DISTRIBUTED_DOWNLOAD_AND_AUTOMATIC_DECOMPRESSION%
set mDirCurrentProjAndroid=!DIR_PROJ_ANDROID_ANZHI!
set mPathCurrentProjAndroid=%PATH_APP_PLAY%\!mDirCurrentProjAndroid!
set mPathProjAndroidAssetsIntegration=!mPathCurrentProjAndroid!
call %PATH_AUTOMATIC_BUILD%\%batchAssetsIntegrationBefore%
call %PATH_AUTOMATIC_BUILD%\%batchAssetsIntegration%
call %PATH_AUTOMATIC_BUILD%\%batchAssetsIntegrationAfter%
call %PATH_AUTOMATIC_BUILD%\%batchAssetsConfusion%
call %PATH_AUTOMATIC_BUILD%\%batchBackupAssets%
for %%i in (!A_DIRS_PROJ_ANDROID_APK_LOAD_2!) do (
  if not "%%i" == "!DIR_PROJ_ANDROID_ANZHI!" (
    set mDirCurrentProjAndroid=%%i
    set mPathCurrentProjAndroid=%PATH_APP_PLAY%\!mDirCurrentProjAndroid!
    call %PATH_AUTOMATIC_BUILD%\%batchAssetsIntegrationBefore%
    echo ----- copy assets to !mDirCurrentProjAndroid! start -----
    echo a | xcopy /s /e /a /c /q !mPathProjAndroidAssetsIntegration!\%DIR_ASSETS%\* !mPathCurrentProjAndroid!\%DIR_ASSETS%\
    call %PATH_AUTOMATIC_BUILD%\%batchAssetsIntegrationAfter%
    echo ----- copy assets to !mDirCurrentProjAndroid! end -----
  )
)
set endTimeApkLoad2=%time%
echo ----- all channels assets generation apk load 2 end -----
if defined mDebugPause pause

set mEndTimeAllChannelsAssetsGeneration=%time%
echo ----- all channels assets generation end -----

echo "startTimeApkLoad1=%startTimeApkLoad1%"
echo "  endTimeApkLoad1=%endTimeApkLoad1%"
echo "startTimeApkLoad2=%startTimeApkLoad2%"
echo "  endTimeApkLoad2=%endTimeApkLoad2%"
echo "startTimeApkLoad0=%startTimeApkLoad0%"
echo "  endTimeApkLoad0=%endTimeApkLoad0%"