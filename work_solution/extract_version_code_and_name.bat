@echo off
cls
set OUTPUT_FILE=versionCode_and_versionName.txt
find "android:version" AndroidManifest.xml > %OUTPUT_FILE%
type %OUTPUT_FILE%
echo.
echo --------------------------------------------------------
setlocal DisableDelayedExpansion enableExtensions
set VERSION_CODE=
for /f "skip=2 tokens=*" %%i in (%OUTPUT_FILE%) do (
  set TEMP_VERSION_CODE=%%i
  echo %TEMP_VERSION_CODE%
  setlocal EnableDelayedExpansion
:: This can be optimized by splitting the string.
  set VERSION_CODE=!TEMP_VERSION_CODE:~21,4!
  echo %VERSION_CODE%
  goto read_version_code_end
  endlocal
)
:read_version_code_end
echo %VERSION_CODE%
echo --------------------------------------------------------

setlocal DisableDelayedExpansion enableExtensions
set VERSION_NAME=
for /f "skip=3 tokens=*" %%j in (%OUTPUT_FILE%) do (
  set TEMP_VERSION_NAME=%%j
  echo %TEMP_VERSION_NAME%
  setlocal EnableDelayedExpansion
  set VERSION_NAME=!TEMP_VERSION_NAME:~21,6!
  echo %VERSION_NAME%
  goto read_version_name_end
  endlocal
)
:read_version_name_end
echo %VERSION_NAME%
