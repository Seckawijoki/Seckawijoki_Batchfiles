@echo off
setlocal EnableDelayedExpansion

set rootDir=F:\trunk\env1\client\iworld

for /r  %rootDir% %%i in (*) do (
    for %%a in (%%i) do set fileDate=%%~ta
    echo %%i 's date : !fileDate!
)