@echo off
rem ---------- Deprecated ----------
setlocal EnableDelayedExpansion

rem ---------- manual batch script name ----------
set BATCH_NDK_BUILD=点我执行NDK编译.bat
set BATCH_ASSETS_GENERATION=点我生成assets文件夹.bat
set BATCH_ONE_PROJECT_BUILD=点我构建本项目.bat

cd %PATH_AUTOMATIC_BUILD%

for %%i in (%A_DIRS_PROJ_ANDROID%) do (
  set mDirCurrentProjAndroid=%%i
  cd %PATH_APP_PLAY%\!mDirCurrentProjAndroid!
  echo.
  
  echo %PATH_AUTOMATIC_BUILD%\automatic_build_entrance.bat %DIR_TRUNK% %DIR_ENV_1% %mPathNdkBuildCmd% %mNdkBuildAbi% %mApkVersionName% %AUTOMATIC_BUILD_NDK_BUILD% !mDirCurrentProjAndroid! > %BATCH_NDK_BUILD%
  echo 生成文件：!mDirCurrentProjAndroid!\%BATCH_NDK_BUILD%
  
  echo %PATH_AUTOMATIC_BUILD%\automatic_build_entrance.bat %DIR_TRUNK% %DIR_ENV_1% %mPathNdkBuildCmd% %mNdkBuildAbi% %mApkVersionName% %AUTOMATIC_BUILD_ASSETS_GENERATION% !mDirCurrentProjAndroid! > %BATCH_ASSETS_GENERATION%
  echo 生成文件：!mDirCurrentProjAndroid!\%BATCH_ASSETS_GENERATION%
  
  echo %PATH_AUTOMATIC_BUILD%\automatic_build_entrance.bat %DIR_TRUNK% %DIR_ENV_1% %mPathNdkBuildCmd% %mNdkBuildAbi% %mApkVersionName% %AUTOMATIC_BUILD_ONE_SPECIFIC_CHANNEL% !mDirCurrentProjAndroid! > %BATCH_ONE_PROJECT_BUILD%
  echo 生成文件：!mDirCurrentProjAndroid!\%BATCH_ONE_PROJECT_BUILD%
)
