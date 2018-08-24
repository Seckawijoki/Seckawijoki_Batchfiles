@echo off
chcp 65001
set mStartTime=%time%
setlocal EnableDelayedExpansion
rem ---------- Running sequences start ----------
rem -- 1.write version
rem -- 2.ndk-build
rem ------ copy to libs, copy to backup, 7-zip
rem -- 3.integrate assets
rem -- 4.confuse assets
rem ------ copy to backup, 7-zip
rem ---------- Running sequences end ----------

rem ---------- formal parameter ----------
set mDirTrunk=%~1
set mDirEnv1=%~2
set mPathNdkBuildCmd=%~3
set mNdkBuildAbi=%~4
set mApkVersionName=%~5
set automaticBuildType=%~6
set mDirCurrentProjAndroid=%~7
set mApkLoad=%~8

if defined mDebugEcho (
  echo.
  echo mDirTrunk=%~1
  echo mDirEnv1=%~2
  echo mPathNdkBuildCmd=%~3
  echo mNdkBuildAbi=%~4
  echo mApkVersionName=%~5
  echo automaticBuildType=%~6
  echo mDirCurrentProjAndroid=%~7
)

rem ---------- configure global parameter ----------
set DRIVE=%~d0
set PATH_AUTOMATIC_BUILD=%~dp0
set DIR_TRUNK=%mDirTrunk%
set DIR_ENV_1=%mDirEnv1%
set PATH_NDK_BUILD_CMD=%mPathNdkBuildCmd%\ndk-build.cmd

if defined mDebugEcho (
  echo ----- Global variable -----
  echo DRIVE=%DRIVE%
  echo PATH_AUTOMATIC_BUILD=%PATH_AUTOMATIC_BUILD%
  echo DIR_TRUNK=%DIR_TRUNK%
  echo DIR_ENV_1=%DIR_ENV_1%
  echo PATH_NDK_BUILD_CMD=%PATH_NDK_BUILD_CMD%
)

rem ---------- Directories under %DIR_ENV_1% ----------
set DIR_BIN=bin
set DIR_BUILD=build
set DIR_CLIENT=client
set DIR_MAKE_WEB=makeweb

rem ---------- Directories under %DIR_CLIENT% ----------
set DIR_APP_PLAY=AppPlay
set DIR_IWORLD=iworld
set DIR_OGRE_MAIN=OgreMain

rem ---------- Directories under %DIR_APP_PLAY% ----------
set DIR_PROJ_ANDROID=Proj.Android
rem Used for apk load 2 first channel
set DIR_PROJ_ANDROID_ANZHI=Proj.Android.Anzhi
rem Used for apk load 0 first channel
set DIR_PROJ_ANDROID_BLOCKARK=Proj.Android.Blockark
set DIR_PROJ_ANDROID_BLOCKARK_IOS_RES=Proj.Android.BlockarkIosRes
rem Used for apk load 1 first channel and prefix
set DIR_PROJ_ANDROID_MINI=Proj.Android.Mini
set DIR_PROJ_ANDROID_STUDIO=Proj.Android.Studio
set DIR_PROJ_ANDROID_STUDIO_BLOCKARK=Proj.AndroidStudio.Blockark
set DIR_PROJ_ANDROID_TENCENT_QQDT=Proj.Android.TencentQQDT

rem ---------- Directories under each Android Project ----------
set DIR_NDK_BUILD_OUT=jniLibs
set DIR_ASSETS=assets
set DIR_SUB_FILES=sub_files
set DIR_OUTPUT=Backup_automatic_build
set DIR_BACKUP=automatic_build_original_backup

rem ---------- Outer Paths ----------
set PATH_ENV_1=%DRIVE%\%DIR_TRUNK%\%DIR_ENV_1%

rem ---------- Paths under %DIR_ENV_1% ----------
set PATH_BIN=%PATH_ENV_1%\%DIR_BIN%
set PATH_BUILD=%PATH_ENV_1%\%DIR_BUILD%
set PATH_CLIENT=%PATH_ENV_1%\%DIR_CLIENT%
set PATH_MAKE_WEB=%PATH_ENV_1%\%DIR_MAKE_WEB%

rem ---------- Paths under %DIR_CLIENT% ----------
set PATH_APP_PLAY=%PATH_CLIENT%\%DIR_APP_PLAY%
set PATH_IWORLD=%PATH_CLIENT%\%DIR_IWORLD%
set PATH_OGRE_MAIN=%PATH_CLIENT%\%DIR_OGRE_MAIN%

rem ---------- Paths under %DIR_APP_PLAY% -------
set PATH_PROJ_ANDROID_ANZHI=%PATH_APP_PLAY%\%DIR_PROJ_ANDROID_ANZHI%
set PATH_PROJ_ANDROID_BLOCKARK_IOS_RES=%PATH_APP_PLAY%\
set PATH_PROJ_ANDROID_MINI=%PATH_APP_PLAY%\%DIR_PROJ_ANDROID_MINI%
set PATH_PROJ_ANDROID_STUDIO=%PATH_APP_PLAY%\%DIR_PROJ_ANDROID_STUDIO%
set PATH_PROJ_ANDROID_STUDIO_BLOCKARK=%PATH_APP_PLAY%\%DIR_PROJ_ANDROID_STUDIO_BLOCKARK%

rem ---------- Global Array Constants ----------
set A_DIRS_PROJ_ANDROID_ALL=Proj.Android.Mini Proj.Android.Mini18183 Proj.Android.MiniGGZS Proj.Android.MiniJinliYY Proj.Android.MiniJuFeng Proj.Android.MiniKubi Proj.Android.MiniLeiZheng Proj.Android.MiniMeiTu Proj.Android.MiniNubia Proj.Android.MiniQingNing Proj.Android.MiniSmartisan Proj.Android.MiniWuFan Proj.Android.MiniXianGuo Proj.Android.MiniYDMM Proj.Android.MiniYouFang Proj.Android.MiniYYH Proj.Android.MiniZhongXing Proj.Android.Blockark Proj.Android.BlockarkIosRes Proj.AndroidStudio.Blockark Proj.Android.Anzhi Proj.Android.BaiduDK Proj.Android.BaiduSJZS Proj.Android.Coolpad Proj.Android.Dangle Proj.Android.Egame Proj.Android.Gg Proj.Android.Haixin Proj.Android.Huawei Proj.Android.Iqiyi Proj.Android.Jinli Proj.Android.Jrtt Proj.Android.Lenovo Proj.Android.Leshi Proj.Android.T4399 Proj.Android.Meizu Proj.Android.Mi Proj.Android.Migu Proj.Android.Mini Proj.Android.Mumayi Proj.Android.Muzhiwan Proj.Android.Oppo Proj.Android.Qihoo Proj.Android.Samsung Proj.Android.SougouLLQ Proj.Android.SougouSJZS Proj.Android.SougouSS Proj.Android.SougouYX Proj.Android.Tencent Proj.Android.TencentQQDT Proj.Android.TianTian Proj.Android.uc Proj.Android.Vivo Proj.Android.Wo
set A_DIRS_PROJ_ANDROID_ALL=Proj.Android.Mini Proj.Android.Mini18183 Proj.Android.Blockark Proj.Android.BlockarkIosRes Proj.Android.Anzhi Proj.Android.BaiduDK 

set A_DIRS_PROJ_ANDROID_APK_LOAD_0=Proj.Android.Blockark Proj.Android.BlockarkIosRes Proj.AndroidStudio.Blockark
set A_DIRS_PROJ_ANDROID_APK_LOAD_0=Proj.Android.Blockark Proj.Android.BlockarkIosRes

set A_DIRS_PROJ_ANDROID_APK_LOAD_1=Proj.Android.Mini Proj.Android.Mini18183 Proj.Android.MiniGGZS Proj.Android.MiniJinliYY Proj.Android.MiniJuFeng Proj.Android.MiniKubi Proj.Android.MiniLeiZheng Proj.Android.MiniMeiTu Proj.Android.MiniNubia Proj.Android.MiniQingNing Proj.Android.MiniSmartisan Proj.Android.MiniWuFan Proj.Android.MiniXianGuo Proj.Android.MiniYDMM Proj.Android.MiniYouFang Proj.Android.MiniYYH Proj.Android.MiniZhongXing
set A_DIRS_PROJ_ANDROID_APK_LOAD_1=Proj.Android.Mini Proj.Android.Mini18183

set A_DIRS_PROJ_ANDROID_APK_LOAD_2=Proj.Android.Anzhi Proj.Android.BaiduDK Proj.Android.BaiduSJZS Proj.Android.Coolpad Proj.Android.Dangle Proj.Android.Egame Proj.Android.Gg Proj.Android.Haixin Proj.Android.Huawei Proj.Android.Iqiyi Proj.Android.Jinli Proj.Android.Jrtt Proj.Android.Lenovo Proj.Android.Leshi Proj.Android.T4399 Proj.Android.Meizu Proj.Android.Mi Proj.Android.Migu Proj.Android.Mini Proj.Android.Mumayi Proj.Android.Muzhiwan Proj.Android.Oppo Proj.Android.Qihoo Proj.Android.Samsung Proj.Android.SougouLLQ Proj.Android.SougouSJZS Proj.Android.SougouSS Proj.Android.SougouYX Proj.Android.Tencent Proj.Android.TencentQQDT Proj.Android.TianTian Proj.Android.uc Proj.Android.Vivo Proj.Android.Wo
set A_DIRS_PROJ_ANDROID_APK_LOAD_2=Proj.Android.Anzhi Proj.Android.BaiduDK

rem ---------- Global Paramters: PROJ_TYPE ----------
set PROJ_TYPE_ADT=PROJ_TYPE_ADT
set PROJ_TYPE_MINIBETA=PROJ_TYPE_MINIBETA
set PROJ_TYPE_OVERSEAS=PROJ_TYPE_OVERSEAS
set PROJ_TYPE_TENCENT_QQDT=PROJ_TYPE_TENCENT_QQDT

rem ---------- Global Paramters: APK_LOAD ----------
set APK_LOAD_NONE=0
set APK_LOAD_DISTRIBUTED_DOWNLOAD=1
set APK_LOAD_DISTRIBUTED_DOWNLOAD_AND_AUTOMATIC_DECOMPRESSION=2

rem ---------- Global Paramters: SUFFIX ----------
set SUFFIX_EXE=.exe
set SUFFIX_ARCH=_32

rem ---------- local parameter ---------- 
set mPathCurrentProjAndroid=%PATH_APP_PLAY%\%mDirCurrentProjAndroid%

set mPathProjAndroidNdkBuild=%mPathCurrentProjAndroid%
set mPathProjAndroidAssetsIntegration=%mPathCurrentProjAndroid%
set mPathProjAndroidAssetsConfusion=%mPathCurrentProjAndroid%

rem ---------- local build constants ---------- 
set AUTOMATIC_BUILD_WRITE_VERSION=0
set AUTOMATIC_BUILD_ONE_SPECIFIC_CHANNEL=1
set AUTOMATIC_BUILD_NDK_BUILD=2
set AUTOMATIC_BUILD_ASSETS_INTEGRATION=3
set AUTOMATIC_BUILD_ASSETS_CONFUSION=4
set AUTOMATIC_BUILD_NDK_BUILD_AND_ASSETS_INTEGRATION=5
set AUTOMATIC_BUILD_ASSETS_GENERATION=6
set AUTOMATIC_BUILD_APK=7
set AUTOMATIC_BUILD_BACKUP_AND_OUTPUT=8
set AUTOMATIC_BUILD_ALL_CHANNELS=9
set AUTOMATIC_BUILD_ALL_CHANNELS_NDK_BUILD=10
set AUTOMATIC_BUILD_ALL_CHANNELS_ASSETS_GENERATION=11
set AUTOMATIC_BUILD_ALL_CHANNELS_BUILD_APK=12
set AUTOMATIC_BUILD_BACKUP_ALL_CHANNELS_APK=13

set DEPRECATED_BUILD_TEST=-1
set DEPRECATED_BUILD_COPY_MANUAL_BATCH=-3
set DEPRECATED_BUILD_PRODUCE_ALL_BATCHES=-4
set DEPRECATED_BUILD_CREATE_BATCHES_IN_EACH_PROJECT=-5
set DEPRECATED_BUILD_CREATE_LOCAL_MANUAL_BATCHES=-6
set POST_BUILD_BACKUP_SO_FILES=-7
set POST_BUILD_BACKUP_ASSETS=-8
set DEPRECATED_BUILD_ALL_CHANNELS_NDK_BUILD_AND_ASSETS_GENERATION=-9
set DEPRECATED_BUILD_ALL_CHANNELS_NDK_BUILD_AND_BUILD_APK=-10
set DEPRECATED_BUILD_ALL_CHANNELS_ASSETS_GENERATION_AND_BUILD_APK=-11
set DEPRECATED_BUILD_BACKUP_ALL_CHANNELS_ASSETS=-12
set PRE_BUILD_TORTOISE_SVN_UPDATE=-13
set POST_BUILD_DELETE_BACKUP_A_WEEK_AGO=-14

rem ---------- configure mApkLoad ---------- 
rem ----- others: 2 -----
set mApkLoad=%APK_LOAD_DISTRIBUTED_DOWNLOAD_AND_AUTOMATIC_DECOMPRESSION%
rem ----- mini cps: 1 -----
if "%mDirCurrentProjAndroid:~0,17%" == "%DIR_PROJ_ANDROID_MINI%" set mApkLoad=%APK_LOAD_DISTRIBUTED_DOWNLOAD%
rem ----- ios and overseas: 0 -----
if "%mDirCurrentProjAndroid%" == "%DIR_PROJ_ANDROID_BLOCKARK%" set mApkLoad=%APK_LOAD_NONE%
if "%mDirCurrentProjAndroid%" == "%DIR_PROJ_ANDROID_BLOCKARK_IOS_RES%" set mApkLoad=%APK_LOAD_NONE%
if "%mDirCurrentProjAndroid%" == "%DIR_PROJ_ANDROID_STUDIO_BLOCKARK%" set mApkLoad=%APK_LOAD_NONE%

rem ---------- call the automatic build script ----------
set batchWriteVersion=automatic_build_write_version.bat

set batchAllChannelsNdkBuild=automatic_build_all_channels_ndk_build.bat
set batchAllChannelsAssetsGeneration=automatic_build_all_channels_assets_generation.bat
set batchAllChannelsBuildApk=automatic_build_all_channels_build_apk.bat
set batchNdkBuild=automatic_build_ndk_build.bat
set batchCopySoFilesToLibs=automatic_build_copy_so_files_to_libs.bat
set batchBackupSoFiles=automatic_build_backup_so_files.bat
set batchAssetsIntegrationBefore=automatic_build_assets_integration_before.bat
set batchAssetsIntegration=automatic_build_assets_integration.bat
set batchAssetsIntegrationAfter=automatic_build_assets_integration_after.bat
set batchAssetsConfusion=automatic_build_assets_confusion.bat
set batchBackupAssets=automatic_build_backup_assets.bat
set batchBuildApk=automatic_build_apk.bat
set batchBackupAllChannelsApk=automatic_build_backup_all_channels_apk.bat

set batchCopyNdkBuildBatch=deprecated_build_copy_ndk_build_batch.bat
set batchCopyAssetsGenerationBatch=deprecated_build_copy_assets_generation_batch.bat
set batchCopyOneProjectBuildBatch=deprecated_build_copy_one_project_build_batch.bat
set batchProduceAllBatches=deprecated_build_produce_all_batches.bat
set batchCreateBatchesInEachProject=deprecated_build_create_batches_in_each_project.bat
set batchCreateLocalManualBatches=deprecated_build_create_local_manual_batches.bat
set batchBackupAllChannelsAssets=deprecated_build_backup_all_channels_assets.bat
set batchTortoiseSvnUpdate=pre_build_tortoise_svn_update.bat
set batchDeleteBackupAWeekAgo=post_build_delete_backup_a_week_ago.bat

set batchTest=deprecated_build_test.bat

echo.
echo ----- Variable before running -----
echo DIR_TRUNK = %DIR_TRUNK%
echo DIR_ENV_1 = %DIR_ENV_1%
echo PATH_NDK_BUILD_CMD = %PATH_NDK_BUILD_CMD%
echo mNdkBuildAbi = %mNdkBuildAbi%
echo mApkVersionName = %mApkVersionName%
echo automaticBuildType = %automaticBuildType%
echo mDirCurrentProjAndroid = %mDirCurrentProjAndroid%
echo mPathCurrentProjAndroid = %mPathCurrentProjAndroid%
echo mApkLoad = %mApkLoad%

rem -------------------- Get SVN Revision --------------------
%DRIVE%
cd %DRIVE%\%DIR_TRUNK%\%DIR_ENV_1%
set fileTemp=svn_info
svn info > %fileTemp%
for /f "tokens=2 skip=6" %%i in (%fileTemp%) do (
  if not defined bGetSvnRevision (
    set mSvnRevision=%%i
    set bGetSvnRevision=1
  )
  goto :end_get_svn_info
)
:end_get_svn_info
echo mSvnRevision = %mSvnRevision%
del /q %fileTemp%

rem ------------------------------ call the automatic build script sequentially ------------------------------
%DRIVE%

if "%mDirCurrentProjAndroid%" == "" (
  echo The to-be-built project has not be specified. 
  echo Exit.
  pause
  exit
)

if %automaticBuildType% == %AUTOMATIC_BUILD_WRITE_VERSION% (
  call %PATH_AUTOMATIC_BUILD%\%batchWriteVersion%
)
if %automaticBuildType% == %AUTOMATIC_BUILD_ONE_SPECIFIC_CHANNEL% (
  call %PATH_AUTOMATIC_BUILD%\%batchWriteVersion%
  
  call %PATH_AUTOMATIC_BUILD%\%batchNdkBuild%
  call %PATH_AUTOMATIC_BUILD%\%batchCopySoFilesToLibs%
  call %PATH_AUTOMATIC_BUILD%\%batchBackupSoFiles%
  
  call %PATH_AUTOMATIC_BUILD%\%batchAssetsIntegrationBefore%
  call %PATH_AUTOMATIC_BUILD%\%batchAssetsIntegration%
  call %PATH_AUTOMATIC_BUILD%\%batchAssetsIntegrationAfter%
  call %PATH_AUTOMATIC_BUILD%\%batchAssetsConfusion%
  call %PATH_AUTOMATIC_BUILD%\%batchBackupAssets%
  
  call %PATH_AUTOMATIC_BUILD%\%batchBuildApk%
  
  echo "mStartTimeNdkBuild = !mStartTimeNdkBuild!"
  echo "  mEndTimeNdkBuild = !mEndTimeNdkBuild!"
  echo "mStartTimeAssetsIntegration = !mStartTimeAssetsIntegration!"
  echo "  mEndTimeAssetsIntegration = !mEndTimeAssetsIntegration!"
  echo "mStartTimeAssetsConfusion = !mStartTimeAssetsConfusion!"
  echo "  mEndTimeAssetsConfusion = !mEndTimeAssetsConfusion!"
  echo "mStartTimeBuildApk = !mStartTimeBuildApk!"
  echo "  mEndTimeBuildApk = !mEndTimeBuildApk!"
)
if %automaticBuildType% == %AUTOMATIC_BUILD_NDK_BUILD% (
  call %PATH_AUTOMATIC_BUILD%\%batchWriteVersion%
  call %PATH_AUTOMATIC_BUILD%\%batchNdkBuild%
  call %PATH_AUTOMATIC_BUILD%\%batchCopySoFilesToLibs%
  call %PATH_AUTOMATIC_BUILD%\%batchBackupSoFiles%
  echo "mStartTimeNdkBuild = !mStartTimeNdkBuild!"
  echo "  mEndTimeNdkBuild = !mEndTimeNdkBuild!"
)
if %automaticBuildType% == %AUTOMATIC_BUILD_ASSETS_GENERATION% (
  call %PATH_AUTOMATIC_BUILD%\%batchAssetsIntegrationBefore%
  call %PATH_AUTOMATIC_BUILD%\%batchAssetsIntegration%
  call %PATH_AUTOMATIC_BUILD%\%batchAssetsIntegrationAfter%
  call %PATH_AUTOMATIC_BUILD%\%batchAssetsConfusion%
  call %PATH_AUTOMATIC_BUILD%\%batchBackupAssets%
  
  echo "mStartTimeAssetsIntegration = !mStartTimeAssetsIntegration!"
  echo "  mEndTimeAssetsIntegration = !mEndTimeAssetsIntegration!"
  echo "mStartTimeAssetsConfusion = !mStartTimeAssetsConfusion!"
  echo "  mEndTimeAssetsConfusion = !mEndTimeAssetsConfusion!"
)
if %automaticBuildType% == %AUTOMATIC_BUILD_APK% (
  call %PATH_AUTOMATIC_BUILD%\%batchWriteVersion%
  call %PATH_AUTOMATIC_BUILD%\%batchBuildApk%
  echo "mStartTimeBuildApk = !mStartTimeBuildApk!"
  echo "  mEndTimeBuildApk = !mEndTimeBuildApk!"
)
if %automaticBuildType% == %AUTOMATIC_BUILD_BACKUP_AND_OUTPUT% (
  call %PATH_AUTOMATIC_BUILD%\%batchBackupSoFiles%
  call %PATH_AUTOMATIC_BUILD%\%batchBackupAssets%
)
if %automaticBuildType% == %POST_BUILD_BACKUP_SO_FILES% (
  call %PATH_AUTOMATIC_BUILD%\%batchBackupSoFiles%
)
if %automaticBuildType% == %POST_BUILD_BACKUP_ASSETS% (
  call %PATH_AUTOMATIC_BUILD%\%batchBackupAssets%
)
if %automaticBuildType% == %AUTOMATIC_BUILD_ALL_CHANNELS% (
  call %PATH_AUTOMATIC_BUILD%\%batchAllChannelsNdkBuild%
  call %PATH_AUTOMATIC_BUILD%\%batchAllChannelsAssetsGeneration%
  call %PATH_AUTOMATIC_BUILD%\%batchAllChannelsBuildApk%
  call %PATH_AUTOMATIC_BUILD%\%batchBackupAllChannelsApk%

  echo "mStartTimeAllChannelsNdkBuild = !mStartTimeAllChannelsNdkBuild!"
  echo "  mEndTimeAllChannelsNdkBuild = !mEndTimeAllChannelsNdkBuild!"
  echo "mStartTimeAllChannelsAssetsGeneration = !mStartTimeAllChannelsAssetsGeneration!"
  echo "  mEndTimeAllChannelsAssetsGeneration = !mEndTimeAllChannelsAssetsGeneration!"
  echo "mStartTimeAllChannelsBuildApk = !mStartTimeAllChannelsBuildApk!"
  echo "  mEndTimeAllChannelsBuildApk = !mEndTimeAllChannelsBuildApk!"
  echo "mStartTimeBackupAllChannelsApk = !mStartTimeBackupAllChannelsApk!"
  echo "  mEndTimeBackupAllChannelsApk = !mEndTimeBackupAllChannelsApk!"
  echo "mStartTimeAllChannels = %mStartTimeAllChannels%"
  echo "  mEndTimeAllChannels = %mEndTimeAllChannels%"
)
if %automaticBuildType% == %AUTOMATIC_BUILD_ALL_CHANNELS_NDK_BUILD% (
  call %PATH_AUTOMATIC_BUILD%\%batchAllChannelsNdkBuild%

  echo "mStartTimeAllChannelsNdkBuild = !mStartTimeAllChannelsNdkBuild!"
  echo "  mEndTimeAllChannelsNdkBuild = !mEndTimeAllChannelsNdkBuild!"
)
if %automaticBuildType% == %AUTOMATIC_BUILD_ALL_CHANNELS_ASSETS_GENERATION% (
  call %PATH_AUTOMATIC_BUILD%\%batchAllChannelsAssetsGeneration%

  echo "mStartTimeAllChannelsAssetsGeneration = !mStartTimeAllChannelsAssetsGeneration!"
  echo "  mEndTimeAllChannelsAssetsGeneration = !mEndTimeAllChannelsAssetsGeneration!"
)
if %automaticBuildType% == %AUTOMATIC_BUILD_ALL_CHANNELS_BUILD_APK% (
  call %PATH_AUTOMATIC_BUILD%\%batchAllChannelsBuildApk%
  REM call %PATH_AUTOMATIC_BUILD%\%batchBackupAllChannelsApk%

  echo "mStartTimeAllChannelsBuildApk = !mStartTimeAllChannelsBuildApk!"
  echo "  mEndTimeAllChannelsBuildApk = !mEndTimeAllChannelsBuildApk!"
  echo "mStartTimeBackupAllChannelsApk = !mStartTimeBackupAllChannelsApk!"
  echo "  mEndTimeBackupAllChannelsApk = !mEndTimeBackupAllChannelsApk!"
)
if %automaticBuildType% == %AUTOMATIC_BUILD_BACKUP_ALL_CHANNELS_APK% (
  call %PATH_AUTOMATIC_BUILD%\%batchBackupAllChannelsApk%
  echo "mStartTimeBackupAllChannelsApk = !mStartTimeBackupAllChannelsApk!"
  echo "  mEndTimeBackupAllChannelsApk = !mEndTimeBackupAllChannelsApk!"
)

rem ---------------------------------------- Debug Automatic Build Type start ----------------------------------------
if %automaticBuildType% == %AUTOMATIC_BUILD_ASSETS_INTEGRATION% (
  call %PATH_AUTOMATIC_BUILD%\%batchAssetsIntegrationBefore%
  call %PATH_AUTOMATIC_BUILD%\%batchAssetsIntegration%
  call %PATH_AUTOMATIC_BUILD%\%batchAssetsIntegrationAfter%
  echo "mStartTimeAssetsIntegration = !mStartTimeAssetsIntegration!"
  echo "  mEndTimeAssetsIntegration = !mEndTimeAssetsIntegration!"
)
if %automaticBuildType% == %AUTOMATIC_BUILD_ASSETS_CONFUSION% (
  call %PATH_AUTOMATIC_BUILD%\%batchAssetsConfusion%
  echo "mStartTimeAssetsConfusion = !mStartTimeAssetsConfusion!"
  echo "  mEndTimeAssetsConfusion = !mEndTimeAssetsConfusion!"
)
if %automaticBuildType% == %AUTOMATIC_BUILD_NDK_BUILD_AND_ASSETS_INTEGRATION% (
  call %PATH_AUTOMATIC_BUILD%\%batchNdkBuild%
  call %PATH_AUTOMATIC_BUILD%\%batchCopySoFilesToLibs%
  call %PATH_AUTOMATIC_BUILD%\%batchBackupSoFiles%
  
  call %PATH_AUTOMATIC_BUILD%\%batchAssetsIntegrationBefore%
  call %PATH_AUTOMATIC_BUILD%\%batchAssetsIntegration%
  call %PATH_AUTOMATIC_BUILD%\%batchAssetsIntegrationAfter%
  
  echo "mStartTimeNdkBuild = !mStartTimeNdkBuild!"
  echo "  mEndTimeNdkBuild = !mEndTimeNdkBuild!"
  echo "mStartTimeAssetsIntegration = !mStartTimeAssetsIntegration!"
  echo "  mEndTimeAssetsIntegration = !mEndTimeAssetsIntegration!"
)

if %automaticBuildType% == %DEPRECATED_BUILD_TEST% (
  call %PATH_AUTOMATIC_BUILD%\%batchTest%
)
if %automaticBuildType% == %DEPRECATED_BUILD_COPY_MANUAL_BATCH% (
  call %PATH_AUTOMATIC_BUILD%\%batchCopyNdkBuildBatch%
  call %PATH_AUTOMATIC_BUILD%\%batchCopyAssetsGenerationBatch%
  call %PATH_AUTOMATIC_BUILD%\%batchCopyOneProjectBuildBatch%
)
if %automaticBuildType% == %DEPRECATED_BUILD_PRODUCE_ALL_BATCHES% (
  call %PATH_AUTOMATIC_BUILD%\%batchProduceAllBatches%
)
if %automaticBuildType% == %DEPRECATED_BUILD_CREATE_BATCHES_IN_EACH_PROJECT% (
  call %PATH_AUTOMATIC_BUILD%\%batchCreateBatchesInEachProject%
)
if %automaticBuildType% == %DEPRECATED_BUILD_CREATE_LOCAL_MANUAL_BATCHES% (
  call %PATH_AUTOMATIC_BUILD%\%batchCreateLocalManualBatches%
)
if %automaticBuildType% == %DEPRECATED_BUILD_ALL_CHANNELS_NDK_BUILD_AND_ASSETS_GENERATION% (
  call %PATH_AUTOMATIC_BUILD%\%batchAllChannelsNdkBuild%
  call %PATH_AUTOMATIC_BUILD%\%batchAllChannelsAssetsGeneration%
  call %PATH_AUTOMATIC_BUILD%\%batchAllChannelsBuildApk%

  echo "mStartTimeAllChannelsNdkBuild = !mStartTimeAllChannelsNdkBuild!"
  echo "  mEndTimeAllChannelsNdkBuild = !mEndTimeAllChannelsNdkBuild!"
  echo "mStartTimeAllChannelsAssetsGeneration = !mStartTimeAllChannelsAssetsGeneration!"
  echo "  mEndTimeAllChannelsAssetsGeneration = !mEndTimeAllChannelsAssetsGeneration!"
)
if %automaticBuildType% == %DEPRECATED_BUILD_ALL_CHANNELS_NDK_BUILD_AND_BUILD_APK% (
  call %PATH_AUTOMATIC_BUILD%\%batchAllChannelsNdkBuild%
  call %PATH_AUTOMATIC_BUILD%\%batchAllChannelsBuildApk%

  echo "mStartTimeAllChannelsNdkBuild = !mStartTimeAllChannelsNdkBuild!"
  echo "  mEndTimeAllChannelsNdkBuild = !mEndTimeAllChannelsNdkBuild!"
  echo "mStartTimeAllChannelsBuildApk = !mStartTimeAllChannelsBuildApk!"
  echo "  mEndTimeAllChannelsBuildApk = !mEndTimeAllChannelsBuildApk!"
)
if %automaticBuildType% == %DEPRECATED_BUILD_ALL_CHANNELS_ASSETS_GENERATION_AND_BUILD_APK% (
  call %PATH_AUTOMATIC_BUILD%\%batchAllChannelsAssetsGeneration%
  call %PATH_AUTOMATIC_BUILD%\%batchAllChannelsBuildApk%

  echo "mStartTimeAllChannelsAssetsGeneration = !mStartTimeAllChannelsAssetsGeneration!"
  echo "  mEndTimeAllChannelsAssetsGeneration = !mEndTimeAllChannelsAssetsGeneration!"
  echo "mStartTimeAllChannelsBuildApk = !mStartTimeAllChannelsBuildApk!"
  echo "  mEndTimeAllChannelsBuildApk = !mEndTimeAllChannelsBuildApk!"
)
if %automaticBuildType% == %DEPRECATED_BUILD_BACKUP_ALL_CHANNELS_ASSETS% (
  set startTimeBackupAllChannelsAssets=%time%
  call %PATH_AUTOMATIC_BUILD%\%batchBackupAllChannelsAssets%
  echo "startTimeBackupAllChannelsAssets = %startTimeBackupAllChannelsAssets%"
  echo "  endTimeBackupAllChannelsAssets = %time%"
)
if %automaticBuildType% == %PRE_BUILD_TORTOISE_SVN_UPDATE% (
  call %PATH_AUTOMATIC_BUILD%\%batchTortoiseSvnUpdate%
)
if %automaticBuildType% == %POST_BUILD_DELETE_BACKUP_A_WEEK_AGO% (
  call %PATH_AUTOMATIC_BUILD%\%batchDeleteBackupAWeekAgo%
)
rem ---------------------------------------- Debug Automatic Build Type end ----------------------------------------

if defined mDebugEcho (
  echo mDirCurrentProjAndroid = %mDirCurrentProjAndroid%
  echo mPathCurrentProjAndroid = %mPathCurrentProjAndroid%
  echo automaticBuildType = %automaticBuildType%
)
echo "mStartTime = %mStartTime%"
echo "  mEndTime = %time%"
pause