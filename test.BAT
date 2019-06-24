@echo off
setlocal EnableDelayedExpansion

REM set dir=f:\empty_folder
REM REM mkdir %dir%
REM set rootdir=%cd%
REM mkdir com\google\android\cameraview
REM for /r %rootdir% %%f in (*) do (
REM     set absolutePath=%%f
REM     set relativePath=!absolutePath:%rootdir%\=!
REM     echo relativePath !relativePath!
REM )

set A=
for /r %%i in (dir \\DABAO_PC\Backup_automatic_build\all_channels\_latest_apk\*.apk) do (
    set filename=%%i
    if "!filename:~0,14!" == "miniworldMini" set "A=!A! !filename!"
)
echo !A!