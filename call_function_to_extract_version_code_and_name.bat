@echo off
set VERSION_CODE=
set VERSION_NAME=
set ANDROID_MANIFEST_FILE=AndroidManifest.xml
setlocal EnableDelayedExpansion
call :extract_version_code !ANDROID_MANIFEST_FILE!
echo VERSION_CODE = !VERSION_CODE!
echo.
call :extract_version_name !ANDROID_MANIFEST_FILE!
echo VERSION_NAME = !VERSION_NAME!
echo.
endlocal


::---------------------------------------------------------------  
::-- Desciption: 
::      Extract the variable "android:versionCode" in an AndroidManifest.xml file.
::-- Param: an AndroidManifest.xml file
::-- Global Return: !VERSION_CODE!
::--------------------------------------------------------------- 
:extract_version_code
if "%~1" equ "" goto :eof 
set SEARCHED_FILE=%~1
echo SEARCHED_FILE = !SEARCHED_FILE!
set SEARCH_RESULT_FILE=versionCode_and_versionName.txt
find "android:versionCode" %SEARCHED_FILE% > !SEARCH_RESULT_FILE!
for /f "skip=2 tokens=*" %%i in (%SEARCH_RESULT_FILE%) do (
  set TEMP_VERSION_CODE=%%i
  echo ORIGIN=!TEMP_VERSION_CODE!
  :: This can be optimized by splitting the string.
  set VERSION_CODE=!TEMP_VERSION_CODE:~21,4!
  echo VERSION_CODE = !VERSION_CODE!
  goto :eof
)
goto :eof

::---------------------------------------------------------------  
::-- Desciption: 
::      Extract the variable "android:versionName" in an AndroidManifest.xml file.
::-- Param: an AndroidManifest.xml file
::-- Global Return: !VERSION_NAME!
::--------------------------------------------------------------- 
:extract_version_name
if "%~1" equ "" goto :eof 
set SEARCHED_FILE=%~1
echo SEARCHED_FILE = !SEARCHED_FILE!
set SEARCH_RESULT_FILE=versionCode_and_versionName.txt
find "android:versionName" %SEARCHED_FILE% > !SEARCH_RESULT_FILE!
for /f "skip=2 tokens=*" %%i in (%SEARCH_RESULT_FILE%) do (
  set TEMP_VERSION_NAME=%%i
  echo ORIGIN=!TEMP_VERSION_NAME!
  :: This can be optimized by splitting the string.
  set VERSION_NAME=!TEMP_VERSION_NAME:~21,6!
  echo VERSION_NAME = !VERSION_NAME!
  goto :eof
)
goto :eof


:end
