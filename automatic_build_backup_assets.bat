@echo off

if not exist %DRIVE%\%DIR_OUTPUT% mkdir %DRIVE%\%DIR_OUTPUT%
if not exist %DRIVE%\%DIR_OUTPUT%\%DIR_ASSETS% mkdir %DRIVE%\%DIR_OUTPUT%\%DIR_ASSETS%
if not exist %PATH_APP_PLAY%\%DIR_BACKUP% mkdir %PATH_APP_PLAY%\%DIR_BACKUP%

cd %PATH_APP_PLAY%\%DIR_BACKUP%

set currentHour=%time:~0,2%
set projectName=%mDirCurrentProjAndroid:~13%
if "%mDirCurrentProjAndroid%" == "%DIR_PROJ_ANDROID%" set projectName=ProjAndroid
if "%mDirCurrentProjAndroid%" == "%DIR_PROJ_ANDROID_STUDIO_BLOCKARK%" set projectName=AndroidStudioBlockark
echo projectName = %projectName%
if %currentHour% lss 10 (
  rem set dirBackupAssets=assets_%mDirCurrentProjAndroid%_%date:~0,4%-%date:~5,2%-%date:~8,2%%date:~11,2%0%time:~1,1%-%time:~3,2%-%time:~6,2%.%time:~9,2%
  set dirBackupAssets=assets_%projectName%_%date:~3,4%%date:~8,2%%date:~11,2%_0%time:~1,1%%time:~3,2%%time:~6,2%_%mApkVersionName%_%DIR_ENV_1%
) else (
  rem set dirBackupAssets=assets_%mDirCurrentProjAndroid%_%date:~0,4%-%date:~5,2%-%date:~8,2%%date:~11,2%%time:~0,2%-%time:~3,2%-%time:~6,2%.%time:~9,2%
  set dirBackupAssets=assets_%projectName%_%date:~3,4%%date:~8,2%%date:~11,2%_%time:~0,2%%time:~3,2%%time:~6,2%_%mApkVersionName%_%DIR_ENV_1%
)

echo dirBackupAssets = %dirBackupAssets%

if "%mPathProjAndroidAssetsIntegration%" == "" (
  set mPathProjAndroidAssetsIntegration=%mPathCurrentProjAndroid%
)

echo ----- backup %mDirCurrentProjAndroid% assets start -----
echo a | xcopy /s /e /a /q %mPathProjAndroidAssetsIntegration%\%DIR_ASSETS%\* %dirBackupAssets%\
echo ----- backup %mDirCurrentProjAndroid% assets end -----

if "%mProjType%" == "%PROJ_TYPE_BLOCKARK_IOS_RES%" (
  set suffix=zip
) else (
  set suffix=7z
)
echo ----- %suffix% %mDirCurrentProjAndroid% assets in backup start -----
7z a -mx9 %DRIVE%\%DIR_OUTPUT%\%DIR_ASSETS%\%dirBackupAssets%\%DIR_ASSETS%.%suffix% %mPathProjAndroidAssetsIntegration%\%DIR_ASSETS%\*
echo ----- %suffix% %mDirCurrentProjAndroid% assets in backup end -----