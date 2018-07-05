@echo off

set FILE_ANDROID_MANIFEST_XML=AndroidManifest.xml
rem  ---------- if the version name empty, try to extract that from cpp file ----------
rem  ---------- edit versionCode versionName in AndroidManifest.xml start ----------
%DRIVE%
rem set APK_VERSION_NAME=0.26.9
echo APK_VERSION_NAME = %APK_VERSION_NAME%

if "%APK_VERSION_NAME%" equ "" (
  rem  ----- extract sClientVersion start -----
  echo Extract apk versionName from ClientManager.cpp ...
  set mApkVersionName=
  setlocal EnableDelayedExpansion
  setlocal EnableDelayedExpansion
  call :extract_sClientVersion %PATH_IWORLD%\ClientManager.cpp
  echo mApkVersionName = !mApkVersionName!
  set APK_VERSION_NAME = !mApkVersionName!
  endlocal
  echo Extract apk versionName from ClientManager.cpp successfully.
  rem  ----- extract sClientVersion end -----
)

if "%APK_VERSION_NAME%" neq "" (
  rem  ----- split the %mApkVersionName% start -----
  echo --- splite apkVersionName start ---
  set mOldVersionCodeDigit1=
  set mOldVersionCodeDigit2=
  set mOldVersionCodeDigit3=
  setlocal EnableDelayedExpansion
  call :split_the_version_code !APK_VERSION_NAME!
  echo mOldVersionCodeDigit1 = !mOldVersionCodeDigit1!
  echo mOldVersionCodeDigit2 = !mOldVersionCodeDigit2!
  echo mOldVersionCodeDigit3 = !mOldVersionCodeDigit3!
  echo --- splite apkVersionName end ---
  rem  ----- split the %mApkVersionName% end -----

  rem  ----- Calculate the new versionCode -----
  echo --- calculate newVersionCode start ---
  set /a newVersionCode = !mOldVersionCodeDigit1! * 65536 + !mOldVersionCodeDigit2! * 256 + !mOldVersionCodeDigit3!
  set newVersionName=!mApkVersionName!
  echo newVersionCode=!newVersionCode!
  echo newVersionName=!APK_VERSION_NAME!
  echo --- calculate newVersionCode end ---
  endlocal
)

setlocal EnableDelayedExpansion
for %%i in (%A_PATHS_PROJ_ANDROID%) do (
  rem  ----- write versionCode and versionName to Eclipse projects start -----
  set pathCurrentProjAndroid=%%~i
  echo ----- write versionCode and versionName to %%~nxi start -----
  cd !pathCurrentProjAndroid!
  set mOldVersionCode=
  set mOldVersionName=
  set pathAndroidManifestXML=!pathCurrentProjAndroid!\%FILE_ANDROID_MANIFEST_XML%
  call :functionExtractVersionCode !pathAndroidManifestXML!
  call :functionExtractVersionName !pathAndroidManifestXML!
  echo mOldVersionCode = !mOldVersionCode!
  echo mOldVersionName = !mOldVersionName
  REM if not "!mOldVersionCode!" == "" powershell -c "(gc !pathAndroidManifestXML!).Replace('"!mOldVersionCode!', '"!newVersionCode!')|Out-File !pathAndroidManifestXML!"
  REM if not "!mOldVersionName!" == "" powershell -c "(gc !pathAndroidManifestXML!).Replace('"!mOldVersionName!', '"!newVersionName!')|Out-File !pathAndroidManifestXML!"
  powershell -c "(gc !pathAndroidManifestXML!).Replace('android:versionCode=".*?"', '"!newVersionCode!') | Out-File !pathAndroidManifestXML!"
  rem if not "!mOldVersionName!" == "" powershell -c "(gc !pathAndroidManifestXML!).Replace('"!mOldVersionName!', '"!newVersionName!')|Out-File !pathAndroidManifestXML!"
  echo ----- write versionCode and versionName to %%~nxi end -----
  rem  ----- write versionCode and versionName to Eclipse projects end -----
)
endlocal

rem  ----- write versionCode and versionName to Proj.AndroidStudio.Blockark start -----
echo Write versionCode and versionName to %DIR_PROJ_ANDROID_STUDIO_BLOCKARK%...
cd %PATH_PROJ_ANDROID_STUDIO_BLOCKARK%\app\src\main\
set mOldVersionCode=
set mOldVersionName=
set pathAndroidManifestXML=%PATH_PROJ_ANDROID_STUDIO_BLOCKARK%\app\src\main\%FILE_ANDROID_MANIFEST_XML%
setlocal EnableDelayedExpansion
call :functionExtractVersionCode !pathAndroidManifestXML!
call :functionExtractVersionName !pathAndroidManifestXML!
echo mOldVersionCode = !mOldVersionCode!
echo mOldVersionName = !mOldVersionName!
rem if not "!mOldVersionCode!" == "" powershell -c "(gc !pathAndroidManifestXML!).Replace('"!mOldVersionCode!', '"!newVersionCode!')|Out-File !pathAndroidManifestXML!"
rem if not "!mOldVersionName!" == "" powershell -c "(gc !pathAndroidManifestXML!).Replace('"!mOldVersionName!', '"!newVersionName!')|Out-File !pathAndroidManifestXML!"
endlocal
echo Write versionCode and versionName to %DIR_PROJ_ANDROID_STUDIO_BLOCKARK% successfully.
rem  ----- write versionCode and versionName to Proj.AndroidStudio.Blockark end -----
rem  ---------- edit versionCode versionName in AndroidManifest.xml end ----------


rem ---------------------------------------------------------------  
rem -- Desciption: 
rem       Extract the variable "sClientVersion" in a cpp file.
rem -- Param: 
rem       a file path
rem -- Global Return: 
rem       !mApkVersionName!
rem --------------------------------------------------------------- 
:extract_sClientVersion
if "%~1" == "" goto :eof
set fileClientManagerCpp=%~1
echo fileClientManagerCpp = !fileClientManagerCpp!
set fileSearchResult=sClientVersion.txt
find "static const char *sClientVersion" !fileClientManagerCpp! > %fileSearchResult%
set mApkVersionName=
for /f "skip=2 tokens=* delims= " %%i in (%fileSearchResult%) do (
  set tempLine=%%i
  rem  This can be optimized by splitting the string.
  set mApkVersionName=!tempLine:~37,6!
  goto :eof
)
goto :eof

rem ---------------------------------------------------------------  
rem -- Desciption: 
rem       Extract the variable "android:versionName" in an AndroidManifest.xml file.
rem -- Param: 
rem       an AndroidManifest.xml file
rem -- Global Return: 
rem       !mOldVersionCodeDigit1!
rem       !mOldVersionCodeDigit2!
rem       !mOldVersionCodeDigit3!
rem --------------------------------------------------------------- 
:split_the_version_code
if "%~1" == "" goto :eof
set tempVersionCode=%~1
rem  Add value "1*" to "tokens" to read the next iterated element in the for-loop.
for  /f "tokens=1* delims=." %%i in ("%tempVersionCode%") do (
  set mOldVersionCodeDigit1=%%i
  rem  Set the remaining part to the digit.
  set tempVersionCode=%%j
  goto split_version_code_digit_2_start
)
:split_version_code_digit_2_start
for /f "tokens=1* delims=." %%i in ("%tempVersionCode%") do (
  set mOldVersionCodeDigit2=%%i
  set tempVersionCode=%%j
  goto split_version_code_digit_3_start
)
:split_version_code_digit_3_start
for /f "tokens=1* delims=." %%i in ("%tempVersionCode%") do (
  set mOldVersionCodeDigit3=%%i
  goto :eof
)
goto :eof

::---------------------------------------------------------------  
::-- Desciption: 
::      Extract the variable "android:versionCode" with left quote in an AndroidManifest.xml file.
::-- Param: an AndroidManifest.xml file
::-- Global Return: !mOldVersionCode!
::--------------------------------------------------------------- 
:functionExtractVersionCode
if "%~1" equ "" goto :eof 
set fileSearched=%~1
set fileSearchResult=versionCode_and_versionName.txt
find "android:versionCode" %fileSearched% > %fileSearchResult%
for /f "skip=2 tokens=*" %%i in (%fileSearchResult%) do (
  set tempVersionCodeLine=%%i
  :: This can be optimized by splitting the string.
  set mOldVersionCode=!tempVersionCodeLine:~21!
  set mOldVersionCode=!mOldVersionCode:~0,-1!
  echo !mOldVersionCode!
  goto :eof
)
goto :eof

::---------------------------------------------------------------  
::-- Desciption: 
::      Extract the variable "android:versionName" with double quotes in an AndroidManifest.xml file.
::-- Param: an AndroidManifest.xml file
::-- Global Return: !mOldVersionName!
::--------------------------------------------------------------- 
:functionExtractVersionName
if "%~1" equ "" goto :eof 
set fileSearched=%~1
set fileSearchResult=versionCode_and_versionName.txt
find "android:versionName" %fileSearched% > %fileSearchResult%
for /f "skip=2 tokens=*" %%i in (%fileSearchResult%) do (
  set tempVersionNameLine=%%i
  :: This can be optimized by splitting the string.
  set mOldVersionName=!tempVersionNameLine:~21!
  :: It has three cases
  set mOldVersionName=!mOldVersionName:~0,-2!
  echo !mOldVersionName!
  goto :eof
)
goto :eof
