@echo off
set APK_VERSION_NAME=
set CLIENT_MANAGER_CPP_FILE=ClientManager.cpp
if not exist %CLIENT_MANAGER_CPP_FILE% (
  copy \..\Miniworld_projects\client\iworld\%CLIENT_MANAGER_CPP_FILE% .\%CLIENT_MANAGER_CPP_FILE%
)
setlocal EnableDelayedExpansion
call :extract_sClientVersion !CLIENT_MANAGER_CPP_FILE!
echo APK_VERSION_NAME = !APK_VERSION_NAME!
call :extract_sClientVersion ClientManager.cpp
echo APK_VERSION_NAME = !APK_VERSION_NAME!
endlocal


::---------------------------------------------------------------  
::-- Desciption: 
::      Extract the variable "sClientVersion" in a cpp file.
::-- Param: 
::      a file path
::-- Global Return: 
::      !APK_VERSION_NAME!
::--------------------------------------------------------------- 
:extract_sClientVersion
if "%~1" equ "" goto :eof
set CLIENT_MANAGER_CPP_FILE=%~1
echo CLIENT_MANAGER_CPP_FILE = !CLIENT_MANAGER_CPP_FILE!
set SEARCH_RESULT_FILE=sClientVersion.txt
find "static const char *sClientVersion" !CLIENT_MANAGER_CPP_FILE! > !SEARCH_RESULT_FILE!
set APK_VERSION_NAME=
for /f "skip=2 tokens=* delims= " %%i in (!SEARCH_RESULT_FILE!) do (
  set TEMP_LINE=%%i
  :: This can be optimized by splitting the string.
  set APK_VERSION_NAME=!TEMP_LINE:~37,6!
  echo APK_VERSION_NAME = !APK_VERSION_NAME!
  goto :eof
)