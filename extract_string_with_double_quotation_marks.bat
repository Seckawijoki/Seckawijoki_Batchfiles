@echo off
cls
set FILE=extracted_substring_with_double_quotation_marks.txt
echo ------------ CENTENCES  > %FILE%
echo "Ladies and Gentlemen, good afternoon!" >> %FILE%
echo The wedding of "Tornado" Walfuzz. >> %FILE%
echo The phrase "black tea" does not mean the color of tea is "black". >> %FILE%
@echo off

type %FILE%
echo -----------------------------------------------------------

setlocal DisableDelayedExpansion enableExtensions
set SUB_STRING=
for /f "skip=1 delims=" %%i in (%FILE%) do (
  set TEMP_LINE=%%i
  setlocal EnableDelayedExpansion
  echo !TEMP_LINE!
:: This can be optimized by splitting the string.
  set SUB_STRING=!TEMP_LINE:~1,6!
  echo %SUB_STRING%
  goto substring_extraction_end0
  endlocal
)
:substring_extraction_end0
echo %SUB_STRING%
echo -----------------------------------------------------------
setlocal DisableDelayedExpansion enableExtensions
set SUB_STRING=
for /f "skip=2 delims=" %%i in (%FILE%) do (
  set TEMP_LINE=%%i
  setlocal EnableDelayedExpansion
  echo !TEMP_LINE!
  set SUB_STRING=!TEMP_LINE:~16,7!
  echo %SUB_STRING%
  goto substring_extraction_end1
  endlocal
)
:substring_extraction_end1
echo %SUB_STRING%
echo -----------------------------------------------------------
setlocal DisableDelayedExpansion enableExtensions
set SUB_STRING=
for /f "skip=3 delims=" %%i in (%FILE%) do (
  set TEMP_LINE=%%i
  setlocal EnableDelayedExpansion
  echo !TEMP_LINE!
  set SUB_STRING=!TEMP_LINE:~12,9!
  echo %SUB_STRING%
  goto substring_extraction_end2
  endlocal
)
:substring_extraction_end2
echo %SUB_STRING%