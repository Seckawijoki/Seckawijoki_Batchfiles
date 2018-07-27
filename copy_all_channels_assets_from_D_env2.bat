@echo off

setlocal EnableDelayedExpansion

set fileName=assets_in_all_channels_from_D
set pathAppPlayInD=d:\work\env2\client\AppPlay
REM set pathAppPlayInD=f:\trunk\env2\client\AppPlay
set pathAllChannelsCopyFromD=f:\%fileName%
if not exist %pathAllChannelsCopyFromD% mkdir %pathAllChannelsCopyFromD%
for /f "tokens=4" %%i in (' dir %pathAppPlayInD%\Proj.Android* ') do (
  echo %%i
)
for /f "tokens=4" %%i in (' dir %pathAppPlayInD%\Proj.Android.* ') do (
  if exist %pathAppPlayInD%\%%i if exist %pathAppPlayInD%\%%i\assets (
    set dirName=assets_%%i
    if not exist %pathAllChannelsCopyFromD%\!dirName! mkdir %pathAllChannelsCopyFromD%\!dirName!
    echo copied %%i\assets\* :
    echo a | xcopy /a /e /s /c /q %pathAppPlayInD%\%%i\assets\* %pathAllChannelsCopyFromD%\!dirName!\
  )
)
7z a -mx9 f:\Backup_automatic_build\%fileName%.zip %pathAllChannelsCopyFromD%\*