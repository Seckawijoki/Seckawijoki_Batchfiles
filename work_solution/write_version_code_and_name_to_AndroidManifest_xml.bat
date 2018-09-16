@echo off
:: ==============Deprecated==============
set ANDROID_MANIFEST_XML_FILE=AndroidManifest.xml
if not exist %ANDROID_MANIFEST_XML_FILE% (
  copy f:\Miniworld_projects\client\AppPlay\proj.Android.MiniBeta\%ANDROID_MANIFEST_XML_FILE% .\%ANDROID_MANIFEST_XML_FILE%
)
set WRITTEN_FILE=written_AndroidManifest.xml
copy %ANDROID_MANIFEST_XML_FILE% !WRITTEN_FILE!
echo > !WRITTEN_FILE!

set VERSION_CODE=%random%
set VERSION_NAME=%random%.%random%.%random%
set VERSION_CODE_LINE=
set VERSION_NAME_LINE=
set VERSION_CACHE_FILE=versionCode_and_versionName_cache_file.txt
setlocal EnableDelayedExpansion
find "android:version" !ANDROID_MANIFEST_XML_FILE! > !VERSION_CACHE_FILE!

echo %VERSION_CODE%
echo %VERSION_NAME%

type !VERSION_CACHE_FILE!

REM set line_number=0
REM for /f %%i in (!VERSION_CACHE_FILE!) do (
  REM echo !line_number! : %%i
  REM set /a line_number+=1
REM )

call :read_version_code_line !VERSION_CACHE_FILE!
call :read_version_name_line !VERSION_CACHE_FILE!

set new_version_code_line=!VERSION_CODE_LINE:~0,21!%VERSION_CODE%^"
::echo new_version_code_line = !new_version_code_line!

set new_version_name_line=!VERSION_NAME_LINE:~0,21!%VERSION_NAME%^"^>
::echo new_version_name_line = !new_version_name_line!

set current_line_number=1
set written_count=0
set version_code_line_number=
set version_name_line_number=
call :get_version_code_line_number %ANDROID_MANIFEST_XML_FILE%
echo.
call :get_version_name_line_number %ANDROID_MANIFEST_XML_FILE%
echo version_code_line_number = !version_code_line_number!
echo version_name_line_number = !version_name_line_number!

for /f "delims=" %%i in (%ANDROID_MANIFEST_XML_FILE%) do (
  if !current_line_number! == !version_code_line_number! (
    echo !new_version_code_line! >> !WRITTEN_FILE!
  ) else (
    if !current_line_number! == !version_name_line_number! (
      echo !new_version_name_line! >> !WRITTEN_FILE!
    ) else (
      echo %%i >>!WRITTEN_FILE!
    )
  )
  set /a current_line_number+=1
)


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

::---------------------------------------------------------------  
::-- Desciption: 
::      Get the "android:versionCode" line number in a file.
::-- Param: 
::      an AndroidManifest.xml file
::-- Global Return: 
::      !version_code_line_number!
::--------------------------------------------------------------- 
:get_version_code_line_number
if "%~1" == "" goto :eof
set temp_file=%~1
set version_code_line_number=0
set temp_current_line=0
set file_version_code_find_result=version_code_find_result.txt
find "android:versionCode" !temp_file! > !file_version_code_find_result!
for /f "skip=2 tokens=*" %%i in (!file_version_code_find_result!) do (
  set temp_version_code_line=%%i
  echo temp_version_code_line = !temp_version_code_line!
  goto :start_to_get_version_code_line_number
)
:start_to_get_version_code_line_number
for /f "delims=" %%i in (!temp_file!) do (
  if "!temp_version_code_line!" == "%%i" (
    echo temp_version_code_line = !temp_version_code_line!
    echo i = %%i
    set version_code_line_number=!temp_current_line!
    goto :eof
  )
  set /a temp_current_line+=1
)
set version_code_line_number=-1
goto :eof

::---------------------------------------------------------------  
::-- Desciption: 
::      Get the "android:versionName" line number in a file.
::-- Param: 
::      an AndroidManifest.xml file
::-- Global Return: 
::      !version_code_name_number!
::--------------------------------------------------------------- 
:get_version_name_line_number
if "%~1" == "" goto :eof
set temp_file=%~1
set version_name_line_number=0
set temp_current_line=0
set file_version_name_find_result=version_name_find_result.txt
find "android:versionName" !temp_file! > !file_version_name_find_result!
for /f "skip=2 tokens=*" %%i in (!file_version_name_find_result!) do (
  set temp_version_name_line=%%i
  echo temp_version_name_line = !temp_version_name_line!
  goto :start_to_get_version_name_line_number
)
:start_to_get_version_name_line_number
for /f "delims=" %%i in (!temp_file!) do (
  if "!temp_version_name_line!" == "%%i" (
    echo temp_version_name_line = !temp_version_name_line!
    echo i = %%i
    set version_name_line_number=!temp_current_line!
    goto :eof
  )
  set /a temp_current_line+=1
)
set version_name_line_number=-1
goto :eof


::---------------------------------------------------------------  
::-- Desciption: 
::      Check if the string contains "android:versionCode" key string.
::-- Param: 
::      a string
::-- Global Return: 
::      !match_version_code_line!
::--------------------------------------------------------------- 
:is_version_code_line_matched
set "match_version_code_line=false"
if "%~1" == "" goto :eof
set temp_matched_string=%~1
:loop_start_version_code_line_match
if not "!temp_matched_string!" == "" (
  echo temp_matched_string = !temp_matched_string!
  set string_length=
  call :get_length_of_string !temp_matched_string!
  if !string_length! lss 19 goto :eof
  if "!temp_matched_string:~0,19!" == "android:versionCode" (
    set "match_version_code_line=true"
    goto :eof
  )
  set temp_matched_string=!temp_matched_string:~1!
  goto :loop_start_version_code_line_match
)
goto :eof

::---------------------------------------------------------------  
::-- Desciption: 
::      Check if the string contains "android:versionName" key string.
::-- Param: 
::      a string
::-- Global Return: 
::      !match_version_name_line!
::--------------------------------------------------------------- 
:is_version_name_line_matched
set "match_version_name_line=false"
if "%~1" == "" goto :eof
set temp_matched_string=%~1
:loop_start_version_name_line_match
if not "!temp_matched_string!" == "" (
  echo temp_matched_string = !temp_matched_string!
  set string_length=
  call :get_length_of_string !temp_matched_string!
  if !string_length! lss 19 goto :eof
  if "!temp_matched_string:~0,19!" == "android:versionName" (
    set "match_version_name_line=true"
    goto :eof
  )
  set temp_matched_string=!temp_matched_string:~1!
  goto :loop_start_version_name_line_match
)
goto :eof

::---------------------------------------------------------------  
::-- Desciption: 
::      Count the length of string.
::-- Param: 
::      %~1: the string
::-- Global Return: 
::      !string_length!
::--------------------------------------------------------------- 
:get_length_of_string
if "%~1" == "" goto :eof
set count_string=%~1
set /a string_length=0
if "!count_string!" == "" goto :eof
set /a string_length=1
:string_length_loop
if not "!count_string:~1!" == "" (
  set /a string_length+=1
  set count_string=!count_string:~1!
  goto :string_length_loop
)
goto :eof
