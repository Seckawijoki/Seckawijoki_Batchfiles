@echo off
set mStartTime=%time%
setlocal EnableDelayedExpansion
set DEBUG_ECHO=
rem ---------- Running sequences start ----------
rem -- 1.ndk-build
rem -- 2.integrate assets
rem -- 3.confuse assets
rem ---------- Running sequences end ----------

rem ---------- formal parameter ----------
set mDirTrunk=%~1
set mDirEnv1=%~2
set mPathNdkBuildCmd=%~3
set mNDKBuildApi=%~4
set mApkVersionName=%~5
set automaticBuildType=%~6
set mDirCurrentProjAndroid=%~7
set mApkLoad=0

if defined DEBUG_ECHO (
  echo.
  echo mDirTrunk=%~1
  echo mDirEnv1=%~2
  echo mPathNdkBuildCmd=%~3
  echo mNDKBuildApi=%~4
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

if defined DEBUG_ECHO (
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
set DIR_BACKUP=Backup_automatic_build
set DIR_PROJ_ANDROID_BLOCKARK_IOS_RES=Proj.Android.BlockarkIosRes
set DIR_PROJ_ANDROID_GOOGLE=Proj.Android.Google
set DIR_PROJ_ANDROID_MINIBETA=Proj.Android.MiniBeta
set DIR_PROJ_ANDROID_STUDIO=Proj.Android.Studio
set DIR_PROJ_ANDROID_STUDIO_BLOCKARK=Proj.AndroidStudio.Blockark
set DIR_PROJ_ANDROID_TENCENT=Proj.Android.Tencent
set DIR_PROJ_ANDROID_TENCENT_QQDT=Proj.Android.TencentQQDT
set DIR_PROJ_ANDROID_UC=Proj.Android.uc

rem ---------- Directories under each Android Project ----------
set DIR_NDK_BUILD_OUT=jniLibs
set DIR_ASSETS=assets
set DIR_SDK_ASSETS=sdkassets
set DIR_SDK_LIBS=sdklibs

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
set PATH_PROJ_ANDROID_BLOCKARK_IOS_RES=%PATH_APP_PLAY%\
set PATH_PROJ_ANDROID_GOOGLE=%PATH_APP_PLAY%\%DIR_PROJ_ANDROID_GOOGLE%
set PATH_PROJ_ANDROID_MINIBETA=%PATH_APP_PLAY%\%DIR_PROJ_ANDROID_MINIBETA%
set PATH_PROJ_ANDROID_STUDIO=%PATH_APP_PLAY%\%DIR_PROJ_ANDROID_STUDIO%
set PATH_PROJ_ANDROID_STUDIO_BLOCKARK=%PATH_APP_PLAY%\%DIR_PROJ_ANDROID_STUDIO_BLOCKARK%
set PATH_PROJ_ANDROID_TENCENT=%PATH_APP_PLAY%\%DIR_PROJ_ANDROID_TENCENT%
set PATH_PROJ_ANDROID_TENCENT_QQDT=%PATH_APP_PLAY%\%DIR_PROJ_ANDROID_TENCENT_QQDT%

rem ---------- Other global constants ----------
set A_PATHS_OVERSEAS_PROJ_ANDROID=%PATH_APP_PLAY%\%DIR_PROJ_ANDROID_GOOGLE% %PATH_APP_PLAY%\%DIR_PROJ_ANDROID_STUDIO_BLOCKARK%
set A_DIRS_PROJ_ANDROID=Proj.Android.Huawei Proj.Android.Migu Proj.Android.Wo Proj.Android.Egame Proj.Android.uc Proj.Android.T4399 Proj.Android.Anzhi Proj.Android.Baidu Proj.Android.BaiduDK Proj.Android.BaiduSJZS Proj.Android.BaiduTB Proj.Android.Lenovo Proj.Android.Meizu Proj.Android.Mi Proj.Android.Oppo Proj.Android.Qihoo Proj.Android.Tencent Proj.Android.TencentQQDT Proj.Android.Muzhiwan Proj.Android.Jinli Proj.Android.Mumayi Proj.Android.Wdj Proj.Android.Coolpad Proj.Android.Vivo Proj.Android.Leshi Proj.Android.SougouLLQ Proj.Android.SougouSJZS Proj.Android.SougouSRF Proj.Android.SougouSS Proj.Android.SougouYX Proj.Android.Google Proj.Android.Dianyou Proj.Android.Samsung Proj.Android.Haixin Proj.Android.TencentAce Proj.Android.Kuaifa Proj.Android.Blockark Proj.Android.TianTian Proj.Android.x7sy Proj.Android.Dangle Proj.Android.Gg Proj.Android.Iqiyi Proj.Android.Jrtt Proj.Android.Mini Proj.Android.MiniQingCheng   Proj.Android.MiniJieKu Proj.Android.MiniJuFeng Proj.Android.MiniLeiZheng Proj.Android.MiniSmartisan Proj.Android.MiniYouFang Proj.Android.MiniNubia Proj.Android.MiniKubi Proj.Android.MiniBeta Proj.Android.MiniZhongXing Proj.Android.MiniYYH Proj.Android.MiniYDMM Proj.Android.MiniMeiTu Proj.Android.MiniQingNing Proj.Android.Mini18183 Proj.Android.MiniGGZS Proj.Android.MiniDuoWan Proj.Android.MiniJinliYY Proj.Android.MiniXianGuo Proj.Android.MiniWuFan Proj.Android.Blockark

rem ---test some channels---
set A_DIRS_PROJ_ANDROID=Proj.Android.Huawei Proj.Android.Migu

rem ---------- global paramters: PROJ_TYPE ----------
set PROJ_TYPE_ADT=ADT
set PROJ_TYPE_BLOCKARK_IOS_RES=BLOCKARK_IOS_RES
set PROJ_TYPE_MINIBETA=MINIBETA
set PROJ_TYPE_OVERSEAS_BETA=OVERSEAS_BETA
set PROJ_TYPE_TENCENT_QQDT=TENCENT_QQDT

rem ---------- global paramters: SUFFIX ----------
set SUFFIX_EXE=.exe
set SUFFIX_ARCH=_32

rem ---------- local parameter ---------- 
set mPathProjAndroidNdkBuild=%PATH_PROJ_ANDROID_TENCENT%
set mPathProjAndroidResIntegration=%PATH_PROJ_ANDROID_TENCENT_QQDT%
set mPathProjAndroidAssetsConfusion=%PATH_PROJ_ANDROID_TENCENT_QQDT%

set mPathCurrentProjAndroid=%PATH_APP_PLAY%\%mDirCurrentProjAndroid%

rem ---------- local build constants ---------- 
set AUTOMATIC_BUILD_ALL_CHANNELS=0
set AUTOMATIC_BUILD_ONE_SPECIFIC_CHANNEL=1
set AUTOMATIC_BUILD_NDK_BUILD=2
set AUTOMATIC_BUILD_RES_INTEGRATION=3
set AUTOMATIC_BUILD_ASSETS_CONFUSION=4
set AUTOMATIC_BUILD_NDK_BUILD_AND_RES_INTEGRATION=5
set AUTOMATIC_BUILD_RES_INTEGRATION_AND_ASSETS_CONFUSION=6
set AUTOMATIC_BUILD_TEST=-1
set AUTOMATIC_BUILD_COPY_NDK_BUILD_BATCH=-2

rem ---------- configure mProjType ---------- 
set mProjType=%PROJ_TYPE_ADT%
if "%mDirCurrentProjAndroid%" == "%DIR_PROJ_ANDROID_BLOCKARK_IOS_RES%" set mProjType=%PROJ_TYPE_BLOCKARK_IOS_RES%
if "%mDirCurrentProjAndroid%" == "%DIR_PROJ_ANDROID_MINIBETA%" set mProjType=%PROJ_TYPE_MINIBETA%
if "%mDirCurrentProjAndroid%" == "%DIR_PROJ_ANDROID_GOOGLE%" set mProjType=%PROJ_TYPE_OVERSEAS_BETA%
if "%mDirCurrentProjAndroid%" == "%DIR_PROJ_ANDROID_STUDIO_BLOCKARK%" set mProjType=%PROJ_TYPE_OVERSEAS_BETA%
if "%mDirCurrentProjAndroid%" == "%DIR_PROJ_ANDROID_TENCENT_QQDT%" set mProjType=%PROJ_TYPE_TENCENT_QQDT%


rem ---------- call the automatic build script sequentially ----------
set batchAllChannels=automatic_build_all_channels.bat
set batchNdkBuild=automatic_build_ndk_build.bat
set batchCopySoFileslToLibs=automatic_build_copy_so_files_to_libs.bat
set batchCopySoFilesToBackup=automatic_build_copy_so_files_to_backup.bat
set batchIntegrateRes=automatic_build_integrate_res.bat
set batchConfuseAssets=automatic_build_confuse_assets.bat
set batchCopyAssetsToBackup=automatic_build_copy_assets_to_backup.bat
set batchTest=automatic_build_test.bat
set batchCopyNdkBuildBatch=automatic_build_copy_ndk_build_batch.bat
set batchWriteVersion=automatic_build_write_version.bat

echo.
echo ----- Variable before running -----
echo DIR_TRUNK = %DIR_TRUNK%
echo DIR_ENV_1 = %DIR_ENV_1%
echo PATH_NDK_BUILD_CMD = %PATH_NDK_BUILD_CMD%
echo mNDKBuildApi = %mNDKBuildApi%
echo mApkVersionName = %mApkVersionName%
echo automaticBuildType = %automaticBuildType%
echo mDirCurrentProjAndroid = %mDirCurrentProjAndroid%
echo mPathCurrentProjAndroid = %mPathCurrentProjAndroid%

rem ---------- call the automatic build script sequentially ----------
%DRIVE%

if not %automaticBuildType% == %AUTOMATIC_BUILD_ALL_CHANNELS% if "%mDirCurrentProjAndroid%" == "" (
  echo The to-be-built project has not be specified. 
  echo Exit.
  pause
  exit
)
call %PATH_AUTOMATIC_BUILD%\%batchWriteVersion%
pause
exit
if %automaticBuildType% == %AUTOMATIC_BUILD_ALL_CHANNELS% (
  call %PATH_AUTOMATIC_BUILD%\%batchAllChannels%
)
if %automaticBuildType% == %AUTOMATIC_BUILD_ONE_SPECIFIC_CHANNEL% (
  call %PATH_AUTOMATIC_BUILD%\%batchNdkBuild%
  call %PATH_AUTOMATIC_BUILD%\%batchCopySoFileslToLibs%
  call %PATH_AUTOMATIC_BUILD%\%batchCopySoFilesToBackup%
  call %PATH_AUTOMATIC_BUILD%\%batchCopyNdkBuildBatch%
  call %PATH_AUTOMATIC_BUILD%\%batchIntegrateRes%
  call %PATH_AUTOMATIC_BUILD%\%batchConfuseAssets%
  call %PATH_AUTOMATIC_BUILD%\%batchCopyAssetsToBackup%
)
if %automaticBuildType% == %AUTOMATIC_BUILD_NDK_BUILD% (
  call %PATH_AUTOMATIC_BUILD%\%batchNdkBuild%
  call %PATH_AUTOMATIC_BUILD%\%batchCopySoFileslToLibs%
  call %PATH_AUTOMATIC_BUILD%\%batchCopySoFilesToBackup%
  call %PATH_AUTOMATIC_BUILD%\%batchCopyNdkBuildBatch%
)
if %automaticBuildType% == %AUTOMATIC_BUILD_RES_INTEGRATION% (
  call %PATH_AUTOMATIC_BUILD%\%batchIntegrateRes%
)
if %automaticBuildType% == %AUTOMATIC_BUILD_ASSETS_CONFUSION% (
  call %PATH_AUTOMATIC_BUILD%\%batchConfuseAssets%
)
if %automaticBuildType% == %AUTOMATIC_BUILD_NDK_BUILD_AND_RES_INTEGRATION% (
  call %PATH_AUTOMATIC_BUILD%\%batchNdkBuild%
  call %PATH_AUTOMATIC_BUILD%\%batchCopySoFileslToLibs%
  call %PATH_AUTOMATIC_BUILD%\%batchCopySoFilesToBackup%
  call %PATH_AUTOMATIC_BUILD%\%batchCopyNdkBuildBatch%
  call %PATH_AUTOMATIC_BUILD%\%batchIntegrateRes%
)
if %automaticBuildType% == %AUTOMATIC_BUILD_RES_INTEGRATION_AND_ASSETS_CONFUSION% (
  call %PATH_AUTOMATIC_BUILD%\%batchIntegrateRes%
  call %PATH_AUTOMATIC_BUILD%\%batchConfuseAssets%
  call %PATH_AUTOMATIC_BUILD%\%batchCopyAssetsToBackup%
)
if %automaticBuildType% == %AUTOMATIC_BUILD_TEST% (
  call %PATH_AUTOMATIC_BUILD%\%batchTest%
)
if %automaticBuildType% == %AUTOMATIC_BUILD_COPY_NDK_BUILD_BATCH% (
  call %PATH_AUTOMATIC_BUILD%\%batchCopyNdkBuildBatch%
)

echo "mStartTimeNdkBuild = %mStartTimeNdkBuild%"
echo "  mEndTimeNdkBuild = %mEndTimeNdkBuild%"
echo "mStartTimeResIntegration = %mStartTimeResIntegration%"
echo "  mEndTimeResIntegration = %mEndTimeResIntegration%"
echo "mStartTimeAssetsConfusion = %mStartTimeAssetsConfusion%"
echo "  mEndTimeAssetsConfusion = %mEndTimeAssetsConfusion%"
echo "mStartTime = %mStartTime%"
echo "  mEndTime = %time%"

if defined DEBUG_ECHO (
  echo mDirCurrentProjAndroid = %mDirCurrentProjAndroid%
  echo mPathCurrentProjAndroid = %mPathCurrentProjAndroid%
  echo automaticBuildType = %automaticBuildType%
)

pause