@echo off

%DRIVE%
cd %PATH_APP_PLAY%
if not exist %DRIVE%\%DIR_OUTPUT% mkdir %DRIVE%\%DIR_OUTPUT%
if not exist %PATH_APP_PLAY%\%DIR_BACKUP% mkdir %PATH_APP_PLAY%\%DIR_BACKUP%

set dirAllChannelsAssets=all_channels_assets
if not exist %DIR_BACKUP%\%dirAllChannelsAssets% mkdir %DIR_BACKUP%\%dirAllChannelsAssets%
if exist %DIR_BACKUP%\%dirAllChannelsAssets% rd /q /s %DIR_BACKUP%\%dirAllChannelsAssets%\*

for %%i in (%A_DIRS_PROJ_ANDROID_ALL%) do (
  if exist %PATH_APP_PLAY%\%%i\%DIR_ASSETS% (
    set dirName=assets_%%i
    if exist %%i\bin\!dirName! (
      echo backup %%i\%DIR_ASSETS%\* :
      mkdir %DIR_BACKUP%\%dirAllChannelsAssets%\!dirName!
      echo a | xcopy /a /s /e /c /q %%i\%DIR_ASSETS%\* %DIR_BACKUP%\%dirAllChannelsAssets%\!dirName!
    )
  )
)
7z a -mx9 %DRIVE%\%DIR_OUTPUT%\%dirAllChannelsAssets%.7z %DIR_BACKUP%\%dirAllChannelsAssets%