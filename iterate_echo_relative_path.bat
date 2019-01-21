@echo off
setlocal enableDelayedExpansion
set rootdir=f:\trunk\env1\bin\res
cd F:\cpp_files
for /r %rootdir% %%f in (*) do (
    set b=%%f
    set relativePath=!b:%rootdir%\=!
    REM echo Relative !b:%CD%\=!
    echo Relative !relativePath!
)