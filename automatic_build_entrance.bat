@echo off
setlocal EnableDelayedExpansion
set DEBUG_ECHO=1
rem ---------- Running sequences start ----------
rem -- 1.ndk-build
rem -- 2.integrate assets into Proj.Android.TencentQQDT
rem -- 3.confuse assets in Proj.Android.TencentQQDT
rem -- 4.copy assets to each project
rem ---------- Running sequences end ----------


rem ---------- formal parameter for self debug ----------
REM set mPathNdkBuildCmd=C:\android-ndk-r10e\ndk-build.cmd
REM set mNDKBuildApi=armeabi
REM set mProjType=ADT
REM set mApkLoad=0
REM set mApkVersionName=0.26.9

rem ---------- formal parameter ----------
set mDirEnv1=%~1
set mPathNdkBuildCmd=%~2\ndk-build.cmd
set mNDKBuildApi=%~3
set mDirCurrentProjAndroid=%~4
set mPathCurrentProjAndroid=%PATH_APP_PLAY%\!mDirCurrentProjAndroid!
set mApkVersionName=%~5
set mApkLoad=0
set runNdkBuild=%~6
set runResIntegration=%~7
set runAssetsConfusion=%~8
set runAssetsCopy=%~9

rem ---------- configure global parameter ----------
set DRIVE=%~d0
if defined seckawijoki (
  set DRIVE=f:
  set DIR_ENV_1=Miniworld_projects
)
set DIR_ENV_1=%mDirEnv1%
if not defined mDirEnv1 (
  set DIR_ENV_1=Miniworld_projects
)
if "!DIR_ENV_1!" == "" (
  set DIR_ENV_1=Miniworld_projects
)
set PATH_BATCH_SCRIPT=%~dp0

rem ---------- Directories under %DIR_ENV_1% ----------
set DIR_BIN=bin
set DIR_BUILD=build
set DIR_CLIENT=client
set DIR_MAKE_WEB=makeweb

rem ---------- Directories under %DIR_CLIENT% ----------
set DIR_IWORLD=iworld
set DIR_APP_PLAY=AppPlay

rem ---------- Directories under %DIR_APP_PLAY% ----------
set DIR_PROJ_ANDROID_BLOCKARK_IOS_RES=Proj.Android.BlockarkIosRes
set DIR_PROJ_ANDROID_GOOGLE=Proj.Android.Google
set DIR_PROJ_ANDROID_MINIBETA=Proj.Android.MiniBeta
set DIR_PROJ_ANDROID_STUDIO=Proj.Android.Studio
set DIR_PROJ_ANDROID_STUDIO_BLOCKARK=Proj.AndroidStudio.Blockark
set DIR_PROJ_ANDROID_TENCENT=Proj.Android.Tencent
set DIR_PROJ_ANDROID_TENCENT_QQDT=Proj.Android.TencentQQDT
set DIR_PROJ_ANDROID_UC=Proj.Android.uc

rem ---------- Directories under each Android Project ----------
set DIR_ASSETS=assets
set DIR_SDK_ASSETS=sdkassets
set DIR_SDK_LIBS=sdklibs

rem ---------- Outer Paths ----------
set PATH_ENV_1=%DRIVE%\%DIR_ENV_1%

rem ---------- Paths under %DIR_ENV_1% ----------
set PATH_BIN=%PATH_ENV_1%\%DIR_BIN%
set PATH_BUILD=%PATH_ENV_1%\%DIR_BUILD%
set PATH_CLIENT=%PATH_ENV_1%\%DIR_CLIENT%
set PATH_MAKE_WEB=%PATH_ENV_1%\%DIR_MAKE_WEB%

rem ---------- Paths under %DIR_CLIENT% ----------
set PATH_IWORLD=%PATH_CLIENT%\%DIR_IWORLD%
set PATH_APP_PLAY=%PATH_CLIENT%\%DIR_APP_PLAY%

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
set A_PATHS_PROJ_ANDROID=%PATH_APP_PLAY%\Proj.Android.Huawei %PATH_APP_PLAY%\Proj.Android.Migu %PATH_APP_PLAY%\Proj.Android.Wo %PATH_APP_PLAY%\Proj.Android.Egame %PATH_APP_PLAY%\Proj.Android.uc %PATH_APP_PLAY%\Proj.Android.T4399 %PATH_APP_PLAY%\Proj.Android.Anzhi %PATH_APP_PLAY%\Proj.Android.Baidu %PATH_APP_PLAY%\Proj.Android.BaiduDK %PATH_APP_PLAY%\Proj.Android.BaiduSJZS %PATH_APP_PLAY%\Proj.Android.BaiduTB %PATH_APP_PLAY%\Proj.Android.Lenovo %PATH_APP_PLAY%\Proj.Android.Meizu %PATH_APP_PLAY%\Proj.Android.Mi %PATH_APP_PLAY%\Proj.Android.Oppo %PATH_APP_PLAY%\Proj.Android.Qihoo %PATH_APP_PLAY%\Proj.Android.Tencent %PATH_APP_PLAY%\Proj.Android.TencentQQDT %PATH_APP_PLAY%\Proj.Android.Muzhiwan %PATH_APP_PLAY%\Proj.Android.Jinli %PATH_APP_PLAY%\Proj.Android.Mumayi %PATH_APP_PLAY%\Proj.Android.Wdj %PATH_APP_PLAY%\Proj.Android.Coolpad %PATH_APP_PLAY%\Proj.Android.Vivo %PATH_APP_PLAY%\Proj.Android.Leshi %PATH_APP_PLAY%\Proj.Android.SougouLLQ %PATH_APP_PLAY%\Proj.Android.SougouSJZS %PATH_APP_PLAY%\Proj.Android.SougouSRF %PATH_APP_PLAY%\Proj.Android.SougouSS %PATH_APP_PLAY%\Proj.Android.SougouYX %PATH_APP_PLAY%\Proj.Android.Google %PATH_APP_PLAY%\Proj.Android.Dianyou %PATH_APP_PLAY%\Proj.Android.Samsung %PATH_APP_PLAY%\Proj.Android.Haixin %PATH_APP_PLAY%\Proj.Android.TencentAce %PATH_APP_PLAY%\Proj.Android.Kuaifa %PATH_APP_PLAY%\Proj.Android.Blockark %PATH_APP_PLAY%\Proj.Android.TianTian %PATH_APP_PLAY%\Proj.Android.x7sy %PATH_APP_PLAY%\Proj.Android.Dangle %PATH_APP_PLAY%\Proj.Android.Gg %PATH_APP_PLAY%\Proj.Android.Iqiyi %PATH_APP_PLAY%\Proj.Android.Jrtt %PATH_APP_PLAY%\Proj.Android.Mini %PATH_APP_PLAY%\Proj.Android.MiniQingCheng   %PATH_APP_PLAY%\Proj.Android.MiniJieKu %PATH_APP_PLAY%\Proj.Android.MiniJuFeng %PATH_APP_PLAY%\Proj.Android.MiniLeiZheng %PATH_APP_PLAY%\Proj.Android.MiniSmartisan %PATH_APP_PLAY%\Proj.Android.MiniYouFang %PATH_APP_PLAY%\Proj.Android.MiniNubia %PATH_APP_PLAY%\Proj.Android.MiniKubi %PATH_APP_PLAY%\Proj.Android.MiniBeta %PATH_APP_PLAY%\Proj.Android.MiniZhongXing %PATH_APP_PLAY%\Proj.Android.MiniYYH %PATH_APP_PLAY%\Proj.Android.MiniYDMM %PATH_APP_PLAY%\Proj.Android.MiniMeiTu %PATH_APP_PLAY%\Proj.Android.MiniQingNing %PATH_APP_PLAY%\Proj.Android.Mini18183 %PATH_APP_PLAY%\Proj.Android.MiniGGZS %PATH_APP_PLAY%\Proj.Android.MiniDuoWan %PATH_APP_PLAY%\Proj.Android.MiniJinliYY %PATH_APP_PLAY%\Proj.Android.MiniXianGuo %PATH_APP_PLAY%\Proj.Android.MiniWuFan %PATH_APP_PLAY%\Proj.Android.Blockark

set A_PATHS_PROJ_ANDROID=%PATH_APP_PLAY%\Proj.Android.Huawei %PATH_APP_PLAY%\Proj.Android.Migu

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
set mPathProjAndroidResConfusion=%PATH_PROJ_ANDROID_TENCENT_QQDT%
set mPathProjAndroidAssetsCopying=%PATH_PROJ_ANDROID_TENCENT_QQDT%

rem ---------- configure mProjType ---------- 
set mProjType=%PROJ_TYPE_ADT%
if "%mPathCurrentProjAndroid%" == "%PATH_PROJ_ANDROID_BLOCKARK_IOS_RES%" set mProjType=%PROJ_TYPE_BLOCKARK_IOS_RES%
if "%mPathCurrentProjAndroid%" == "%PATH_PROJ_ANDROID_MINIBETA%" set mProjType=%PROJ_TYPE_MINIBETA%
if "%mPathCurrentProjAndroid%" == "%PATH_PROJ_ANDROID_GOOGLE%" set mProjType=%PROJ_TYPE_OVERSEAS_BETA%
if "%mPathCurrentProjAndroid%" == "%PATH_PROJ_ANDROID_STUDIO_BLOCKARK%" set mProjType=%PROJ_TYPE_OVERSEAS_BETA%
if "%mPathCurrentProjAndroid%" == "%PATH_PROJ_ANDROID_TENCENT_QQDT%" set mProjType=%PROJ_TYPE_TENCENT_QQDT%


rem ---------- call the automatic build script sequentially ----------
%DRIVE%
if not defined runNdkBuild
if not defined runResIntegration
if not defined runAssetsConfusion
if not defined runAssetsCopy (
  call %~dp0\automatic_build_ndk_build_Tencent.bat
  call %~dp0\automatic_build_integrate_assets_into_TencentQQDT.bat
  call %~dp0\automatic_build_confuse_res_of_TencentQQDT.bat
  call %~dp0\automatic_build_write_version.bat
)
if not %runNdkBuild% == 0  call %~dp0\automatic_build_ndk_build_Tencent.bat
if not %runResIntegration% == 0  call %~dp0\automatic_build_integrate_assets_into_TencentQQDT.bat
if not %runAssetsConfusion% == 0  call %~dp0\automatic_build_confuse_res_of_TencentQQDT.bat
if not %runAssetsCopy% == 0  call %~dp0\automatic_build_write_version.bat


call %~dp0\automatic_build_test_part.bat
rem call %~dp0\automatic_build_copy_res_to_each_project.bat
