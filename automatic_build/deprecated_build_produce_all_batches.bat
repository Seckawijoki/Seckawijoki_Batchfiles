@echo off
rem ---------- Deprecated ----------
setlocal EnableDelayedExpansion

cd %PATH_AUTOMATIC_BUILD%
set dirAllBatches=手动点击构建单个项目
set dirNdkBuildBatches=NDK编译
set dirAssetsGenerationBatches=生成assets文件夹
REM set dirSingleProjectBuildBatches = 构建单个项目

if exist !dirAllBatches! del /q /s !dirAllBatches!\*
if not exist !dirAllBatches! mkdir !dirAllBatches!
cd !dirAllBatches!
if not exist !dirNdkBuildBatches! mkdir !dirNdkBuildBatches!
if not exist !dirAssetsGenerationBatches! mkdir !dirAssetsGenerationBatches! 
REM if not exist !dirSingleProjectBuildBatches! mkdir !dirSingleProjectBuildBatches!
if not exist 构建单个项目 mkdir 构建单个项目

for %%i in (%A_DIRS_PROJ_ANDROID%) do (
  set mDirCurrentProjAndroid=%%i
  set channelName=ProjAndroid!mDirCurrentProjAndroid:~13!
  echo.
  
  set batchFile=执行!channelName!的NDK编译.bat
  
  echo %PATH_AUTOMATIC_BUILD%\automatic_build_entrance.bat %DIR_TRUNK% %DIR_ENV_1% %mPathNdkBuildCmd% %mNdkBuildAbi% %mApkVersionName% %AUTOMATIC_BUILD_NDK_BUILD% !mDirCurrentProjAndroid! > !dirNdkBuildBatches!\!batchFile!
  echo 生成文件：!dirNdkBuildBatches!\!batchFile!
  
  set batchFile=生成!channelName!的assets文件夹.bat
  
  echo %PATH_AUTOMATIC_BUILD%\automatic_build_entrance.bat %DIR_TRUNK% %DIR_ENV_1% %mPathNdkBuildCmd% %mNdkBuildAbi% %mApkVersionName% %AUTOMATIC_BUILD_ASSETS_GENERATION% !mDirCurrentProjAndroid! > !dirAssetsGenerationBatches!\!batchFile!
  echo 生成文件：!dirAssetsGenerationBatches!\!batchFile!
  
  set batchFile=构建!channelName!.bat
  
  REM echo %PATH_AUTOMATIC_BUILD%\automatic_build_entrance.bat %DIR_TRUNK% %DIR_ENV_1% %mPathNdkBuildCmd% %mNdkBuildAbi% %mApkVersionName% %AUTOMATIC_BUILD_ONE_SPECIFIC_CHANNEL% !mDirCurrentProjAndroid! >> !dirSingleProjectBuildBatches!\!batchFile!
  echo %PATH_AUTOMATIC_BUILD%\automatic_build_entrance.bat %DIR_TRUNK% %DIR_ENV_1% %mPathNdkBuildCmd% %mNdkBuildAbi% %mApkVersionName% %AUTOMATIC_BUILD_ONE_SPECIFIC_CHANNEL% !mDirCurrentProjAndroid! > 构建单个项目\!batchFile!
  REM echo 生成文件：!dirSingleProjectBuildBatches!\!batchFile!
  echo 生成文件：构建单个项目\!batchFile!
)
