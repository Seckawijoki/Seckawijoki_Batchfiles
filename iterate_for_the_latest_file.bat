@echo off
setlocal EnableDelayedExpansion
dir /od *.*
for /f "skip=4 tokens=4" %%i in ('dir /o-d *.*') do (
  set filename=%%i
  goto :end
)
:end
echo The latest file is !filename!