@echo off
setlocal EnableDelayedExpansion
set dir=f:\empty_folder
REM mkdir %dir%
set rootdir=%cd%
mkdir com\google\android\cameraview
for /r %rootdir% %%f in (*) do (
    set absolutePath=%%f
    set relativePath=!absolutePath:%rootdir%\=!
    echo relativePath !relativePath!
)