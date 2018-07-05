@echo off
set FILE_ANDROID_MANIFEST_XML=AndroidManifest.xml
if not exist %FILE_ANDROID_MANIFEST_XML% (
  copy /y f:\Miniworld_projects\client\AppPlay\proj.Android.MiniBeta\%FILE_ANDROID_MANIFEST_XML% .\%FILE_ANDROID_MANIFEST_XML%
)

set FILE_BE_WRITTEN=written_AndroidManifest.xml
if not exist %FILE_BE_WRITTEN% (
  copy /y %FILE_ANDROID_MANIFEST_XML% %FILE_BE_WRITTEN%
)
set newVersionCode="%random%
set newVersionName="%random%.%random%.%random%"

setlocal EnableDelayedExpansion
set mVersionCode=
set mVersionName=
call :functionExtractVersionCode !FILE_BE_WRITTEN!
call :functionExtractVersionName !FILE_BE_WRITTEN!
echo mVersionCode = !mVersionCode!
echo mVersionName = !mVersionName!
echo newVersionCode = !newVersionCode!
echo newVersionName = !newVersionName!
powershell -c "(gc !FILE_BE_WRITTEN!).Replace('!mVersionCode!', '!newVersionCode!')|Out-File !FILE_BE_WRITTEN!"
powershell -c "(gc !FILE_BE_WRITTEN!).Replace('!mVersionName!', '!newVersionName!')|Out-File !FILE_BE_WRITTEN!"


::---------------------------------------------------------------  
::-- Desciption: 
::      Extract the variable "android:versionCode" with left quote in an AndroidManifest.xml file.
::-- Param: an AndroidManifest.xml file
::-- Global Return: !mVersionCode!
::--------------------------------------------------------------- 
:functionExtractVersionCode
if "%~1" equ "" goto :eof 
set fileSearched=%~1
set fileSearchResult=versionCode_and_versionName.txt
find "android:versionCode" %fileSearched% > !fileSearchResult!
for /f "skip=2 tokens=*" %%i in (%fileSearchResult%) do (
  set tempVersionCodeLine=%%i
  :: This can be optimized by splitting the string.
  set mVersionCode=!tempVersionCodeLine:~20!
  set mVersionCode=!mVersionCode:~0,-1!
  goto :eof
)
goto :eof

::---------------------------------------------------------------  
::-- Desciption: 
::      Extract the variable "android:versionName" with double quotes in an AndroidManifest.xml file.
::-- Param: an AndroidManifest.xml file
::-- Global Return: !mVersionName!
::--------------------------------------------------------------- 
:functionExtractVersionName
if "%~1" equ "" goto :eof 
set fileSearched=%~1
set fileSearchResult=versionCode_and_versionName.txt
find "android:versionName" %fileSearched% > !fileSearchResult!
for /f "skip=2 tokens=*" %%i in (%fileSearchResult%) do (
  set tempVersionNameLine=%%i
  :: This can be optimized by splitting the string.
  set mVersionName=!tempVersionNameLine:~20!
  :: It has three cases
  set mVersionName=!mVersionName:~0,-2!
  goto :eof
)
goto :eof
