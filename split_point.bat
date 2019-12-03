@echo off

set versionName=0....37.5

for /f "tokens=1,9 delims=." %%i in ("%versionName%") do (
    echo %%i
)