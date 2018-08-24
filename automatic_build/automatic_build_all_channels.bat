@echo off

rem ---------- build all channels start ----------
echo ---------- build all channels start ----------
set startTimeAllChannels=%time%
set mDirCurrentProjAndroid=%DIR_PROJ_ANDROID_MINIBETA%
set mPathCurrentProjAndroid=%PATH_PROJ_ANDROID_MINIBETA%
call %PATH_AUTOMATIC_BUILD%\%batchNdkBuild%
call %PATH_AUTOMATIC_BUILD%\%batchCopySoFileslToLibs%
call %PATH_AUTOMATIC_BUILD%\%batchCopySoFilesToBackup%

for %%i in (%A_DIRS_PROJ_ANDROID%) do (
  set mDirCurrentProjAndroid=%%i
  set mPathCurrentProjAndroid=%PATH_APP_PLAY%\%mDirCurrentProjAndroid%
  call %PATH_AUTOMATIC_BUILD%\%batchCopySoFileslToLibs%
  call %PATH_AUTOMATIC_BUILD%\%batchCopyNdkBuildBatch%
  set mProjType=%PROJ_TYPE_ADT%
  if "%mPathCurrentProjAndroid%" == "%PATH_PROJ_ANDROID_BLOCKARK_IOS_RES%" set mProjType=%PROJ_TYPE_BLOCKARK_IOS_RES%
  if "%mPathCurrentProjAndroid%" == "%PATH_PROJ_ANDROID_MINIBETA%" set mProjType=%PROJ_TYPE_MINIBETA%
  if "%mPathCurrentProjAndroid%" == "%PATH_PROJ_ANDROID_GOOGLE%" set mProjType=%PROJ_TYPE_OVERSEAS_BETA%
  if "%mPathCurrentProjAndroid%" == "%PATH_PROJ_ANDROID_STUDIO_BLOCKARK%" set mProjType=%PROJ_TYPE_OVERSEAS_BETA%
  if "%mPathCurrentProjAndroid%" == "%PATH_PROJ_ANDROID_TENCENT_QQDT%" set mProjType=%PROJ_TYPE_TENCENT_QQDT%
  call %PATH_AUTOMATIC_BUILD%\%batchIntegrateRes%
  call %PATH_AUTOMATIC_BUILD%\%batchConfuseAssets%
  call %PATH_AUTOMATIC_BUILD%\%batchCopyAssetsToBackup%
)
set endTimeAllChannels=%time%
echo ---------- build all channels end ----------
echo "startTimeAllChannels = %startTimeAllChannels%"
echo "  endTimeAllChannels = %endTimeAllChannels%"
rem ---------- build all channels end ----------