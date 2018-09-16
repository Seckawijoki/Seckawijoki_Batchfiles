@echo off
set VERSION_CODE=0.25.78
set VERSION_CODE_DIGIT_1=
set VERSION_CODE_DIGIT_2=
set VERSION_CODE_DIGIT_3=
setlocal EnableDelayedExpansion
call :split_the_version_code !VERSION_CODE!
set /a version = !VERSION_CODE_DIGIT_1! * 65536 + !VERSION_CODE_DIGIT_2! * 256 + !VERSION_CODE_DIGIT_3!
echo VERSION_CODE_DIGIT_1 = !VERSION_CODE_DIGIT_1!
echo VERSION_CODE_DIGIT_2 = !VERSION_CODE_DIGIT_2!
echo VERSION_CODE_DIGIT_3 = !VERSION_CODE_DIGIT_3!
echo version = %version%
call :split_the_version_code 0.26.2
echo VERSION_CODE_DIGIT_1 = !VERSION_CODE_DIGIT_1!
echo VERSION_CODE_DIGIT_2 = !VERSION_CODE_DIGIT_2!
echo VERSION_CODE_DIGIT_3 = !VERSION_CODE_DIGIT_3!
endlocal
set /a version = %VERSION_CODE_DIGIT_1% * 65536 + %VERSION_CODE_DIGIT_2% * 256 + %VERSION_CODE_DIGIT_3%
echo version = %version%

::---------------------------------------------------------------  
::-- Desciption: 
::      Extract the variable "android:versionName" in an AndroidManifest.xml file.
::-- Param: 
::      an AndroidManifest.xml file
::-- Global Return: 
::      !VERSION_CODE_DIGIT_1!
::      !VERSION_CODE_DIGIT_2!
::      !VERSION_CODE_DIGIT_3!
::--------------------------------------------------------------- 
:split_the_version_code
if "%~1" equ "" goto :eof
set TEMP_VERSION_CODE=%~1
:: Add value "1*" to "tokens" to read the next iterated element in the for-loop.
for  /f "tokens=1* delims=." %%i in ("%TEMP_VERSION_CODE%") do (
  set VERSION_CODE_DIGIT_1=%%i
  :: Set the remaining part to the digit.
  set TEMP_VERSION_CODE=%%j
  goto split_version_code_digit_2_start
)
:split_version_code_digit_2_start
for /f "tokens=1* delims=." %%i in ("%TEMP_VERSION_CODE%") do (
  set VERSION_CODE_DIGIT_2=%%i
  set TEMP_VERSION_CODE=%%j
  goto split_version_code_digit_3_start
)
:split_version_code_digit_3_start
for /f "tokens=1* delims=." %%i in ("%TEMP_VERSION_CODE%") do (
  set VERSION_CODE_DIGIT_3=%%i
  goto :eof
)
goto :eof