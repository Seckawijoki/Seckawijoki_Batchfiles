@echo off

set OUTPUT_FILE=sClientVersion.txt
set SEARCH_FILE=ClientManager.cpp
copy \..\Miniworld_projects\client\iworld\%SEARCH_FILE% .\%SEARCH_FILE%
find "static const char *sClientVersion" %SEARCH_FILE% > %OUTPUT_FILE%
type %OUTPUT_FILE%
echo.
setlocal DisableDelayedExpansion
set APK_VERSION_NAME=
for /f "skip=2 tokens=* delims= " %%i in (%OUTPUT_FILE%) do (
  set LINE=%%i
  setlocal EnableDelayedExpansion
  :: This can be optimized by splitting the string.
  set APK_VERSION_NAME=!LINE:~37,6!
  echo !APK_VERSION_NAME!
  goto :eof
  endlocal
)
echo %APK_VERSION_NAME%