@echo off
setlocal EnableDelayedExpansion
dir /od *.* /b
for /f  %%i in ('dir /o-d *.* /b') do (
  set filename=%%i
  goto :end
)
:end
echo.
echo The latest file is !filename!