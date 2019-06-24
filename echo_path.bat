@echo off
echo %0
echo %~0
echo %~d0
echo %~p0
echo %~dp0

set absolutePath=%~0

for /f "delims=" %%i in (%absolutePath%) do (
    echo %%i
)

cd F:\trunk\env1\client\AppPlay\ApkBuilderScripts\automatic_build\