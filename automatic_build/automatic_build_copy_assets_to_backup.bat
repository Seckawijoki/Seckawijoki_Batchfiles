@echo off

set currentHour=%time:~0,2%
if %currentHour% lss 10 (
  set dirBackupAssets=assets_%mDirCurrentProjAndroid%_%date:~0,4%-%date:~5,2%-%date:~8,2%%date:~11,2%0%time:~1,1%-%time:~3,2%-%time:~6,2%.%time:~9,2%
) else (
  set dirBackupAssets=assets_%mDirCurrentProjAndroid%_%date:~0,4%-%date:~5,2%-%date:~8,2%%date:~11,2%%time:~0,2%-%time:~3,2%-%time:~6,2%.%time:~9,2%
)
echo dirBackupAssets = %dirBackupAssets%
if not exist %PATH_APP_PLAY%\%DIR_BACKUP% mkdir %PATH_APP_PLAY%\%DIR_BACKUP%
mkdir %PATH_APP_PLAY%\%DIR_BACKUP%\%dirBackupAssets%

:: --------- copy %mDirCurrentProjAndroid% assets to backup ----------
echo ----- copy %mDirCurrentProjAndroid% assets to backup start -----
echo a | xcopy /s /e /a /q %mPathCurrentProjAndroid%\%DIR_ASSETS%\* %PATH_APP_PLAY%\%DIR_BACKUP%\%dirBackupAssets%
echo ----- copy %mDirCurrentProjAndroid% assets to backup end -----
