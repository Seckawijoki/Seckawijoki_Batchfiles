@echo off
set SUBSTRING=
for /f %%i in ('dir /b *.bat') do (
  set var=%%i
  call :extract_string %%i
  echo SUBSTRING : %SUBSTRING%
  echo -------
)
pause

:extract_string
setlocal DisableDelayedExpansion
set FILE=%~1
echo FILE : %FILE%
for /f "skip=2 tokens=*" %%i in (%FILE%) do (
  set TEMP=%%i
  setlocal EnableDelayedExpansion
  echo !TEMP!
  set SUBSTRING=!TEMP:~1,4!
  echo SUBSTRING : %SUBSTRING%
  echo.
  goto :extract_string_end
  endlocal
)
:extract_string_end
goto :eof