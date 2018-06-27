@echo off
:: Set the command "setlocal EnableDelayedExpansion" before set the global variable.

for /f %%i in ('dir /b *.bat') do (
  setlocal EnableDelayedExpansion
  set SUBSTRING=
  call :extract_string_start %%i 
  echo SUBSTRING = !SUBSTRING!
  echo -----------------
  endlocal
)

:extract_string_start
if "%~1" equ "" goto :eof
set FILE=%~1
echo FILE = !FILE!
for /f "skip=2 tokens=*" %%i in (%FILE%) do (
  set TEMP=%%i
  if "!TEMP!" equ "" goto :eof
  echo ORIGIN = !TEMP!
  set SUBSTRING=!TEMP:~3,-3!
  echo SUBSTRING = !SUBSTRING!
  goto :eof
  endlocal
)
goto :eof

:end