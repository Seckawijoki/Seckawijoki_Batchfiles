@echo off
setlocal EnableDelayedExpansion
set VERSION_CODE=%random%
set VERSION_NAME=%random%.%random%.%random%
set VERSION_CODE_LINE=
set VERSION_NAME_LINE=
set ANDROID_MANIFEST_XML_FILE=AndroidManifest.xml
set VERSION_CACHE_FILE=versionCode_and_versionName_cache_file.txt
find "android:version" %ANDROID_MANIFEST_XML_FILE% > %VERSION_CACHE_FILE%
type %VERSION_CACHE_FILE%
echo %VERSION_CODE%
echo %VERSION_NAME%

call :read_version_code_line %VERSION_CACHE_FILE%
call :read_version_name_line %VERSION_CACHE_FILE%
echo VERSION_CODE_LINE = !VERSION_CODE_LINE!
echo VERSION_NAME_LINE = !VERSION_NAME_LINE!



::---------------------------------------------------------------  
::-- Desciption: 
::      Search "android:versionCode" in a file.
::-- Param: an AndroidManifest.xml file
::-- Global Return: !VERSION_CODE_LINE!
::--------------------------------------------------------------- 
:read_version_code_line
if "%~1" equ "" goto :eof 
set SEARCHED_FILE=%~1
set SEARCH_RESULT_FILE=versionCode_and_versionName.txt
find "android:versionCode" %SEARCHED_FILE% > !SEARCH_RESULT_FILE!
for /f "skip=2 tokens=*" %%i in (%SEARCH_RESULT_FILE%) do (
  set VERSION_CODE_LINE=%%i
  goto :eof
)
goto :eof

::---------------------------------------------------------------  
::-- Desciption: 
::      Search "android:versionName" in a file.
::-- Param: an AndroidManifest.xml file
::-- Global Return: !VERSION_NAME_LINE!
::--------------------------------------------------------------- 
:read_version_name_line
if "%~1" equ "" goto :eof 
set SEARCHED_FILE=%~1
set SEARCH_RESULT_FILE=versionCode_and_versionName.txt
find "android:versionName" %SEARCHED_FILE% > !SEARCH_RESULT_FILE!
for /f "skip=2 tokens=*" %%i in (%SEARCH_RESULT_FILE%) do (
  set VERSION_NAME_LINE=%%i
  goto :eof
)
goto :eof

