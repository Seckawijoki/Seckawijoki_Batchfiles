@echo on
cls
set OUTPUT_FILE=sClientVersion.txt
set SEARCH_FILE=ClientManager.cpp
copy \..\Miniworld_projects\client\iworld\%SEARCH_FILE% .\%SEARCH_FILE%
find "static const char *sClientVersion" %SEARCH_FILE% > %OUTPUT_FILE%
type %OUTPUT_FILE%
echo.
set APK_VERSION_NAME=
for /f "skip=2 tokens=* delims= " %%i in (%OUTPUT_FILE%) do (
  set LINE=%%i
  echo %LINE:~37,6%
  set APK_VERSION_NAME=%LINE:~37,6%
  goto :read_apk_version_name_end
)
:read_apk_version_name_end
echo %APK_VERSION_NAME%
pause