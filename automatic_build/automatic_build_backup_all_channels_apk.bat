@echo off

%DRIVE%
cd %PATH_APP_PLAY%
if not exist %DRIVE%\%DIR_OUTPUT% mkdir %DRIVE%\%DIR_OUTPUT%
if not exist %DRIVE%\%DIR_OUTPUT%\all_channels mkdir %DRIVE%\%DIR_OUTPUT%\all_channels
if not exist %PATH_APP_PLAY%\%DIR_BACKUP% mkdir %PATH_APP_PLAY%\%DIR_BACKUP%

set currentHour=%time:~0,2%
if %currentHour% lss 10 (
  set dirAllChannelsApk=all_apk_%date:~3,4%%date:~8,2%%date:~11,2%_0%time:~1,1%%time:~3,2%%time:~6,2%_%mApkVersionName%_%DIR_ENV_1%
) else (
  set dirAllChannelsApk=all_apk_%date:~3,4%%date:~8,2%%date:~11,2%_%time:~0,2%%time:~3,2%%time:~6,2%_%mApkVersionName%_%DIR_ENV_1%
)
mkdir %DIR_BACKUP%\%dirAllChannelsApk%
set mStartTimeBackupAllChannelsApk=%time%
for %%i in (%A_DIRS_PROJ_ANDROID_ALL%) do (
  if exist %PATH_APP_PLAY%\%%i\%DIR_ASSETS% (
    set apkName=%%i-release.apk
    if exist %%i\bin\!apkName! (
      echo backup !apkName! :
      copy %%i\bin\!apkName! %DIR_BACKUP%\%dirAllChannelsApk%\!apkName!
    )
  )
)
7z a -mx9 %DRIVE%\%DIR_OUTPUT%\all_channels\%dirAllChannelsApk%.7z %DIR_BACKUP%\%dirAllChannelsApk%
set mEndTimeBackupAllChannelsApk=%time%