@echo off
setlocal EnableDelayedExpansion
pushd ..\Cpp_files
dir /s /b /od *.*
for /f %%i in ('dir /s /b /o-d *.*') do (
  set filename=%%i
  goto :end
)
:end  
echo The latest file is !filename!
popd