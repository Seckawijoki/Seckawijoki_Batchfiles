@echo off
cls
set FILE=extracted_substring.txt
echo abcdefghijklmnopqrstuvwxyz > %FILE%
echo 0123456789 >> %FILE%
echo abcdefghijklmnopqrstuvwxyz >> %FILE%
echo 0123456789 >> %FILE%
echo abcdefghijklmnopqrstuvwxyz >> %FILE%
echo 0123456789 >> %FILE%
@echo off

set SUBSTRING=
for /f "skip=2 tokens=*" %%i in (%FILE%) do (
  set LINE=%%i
  echo %LINE%
  echo %LINE:~7,2%
  set SUBSTRING=%LINE:~7,2%
  goto substring_extraction_end
)
:substring_extraction_end
echo %SUBSTRING%

for /f "skip=5 tokens=*" %%i in (%FILE%) do (
  set LINE=%%i
  echo %LINE%
  echo %LINE:~7,2%
  set SUBSTRING=%LINE:~7,2%
  goto substring_extraction_end
)
:substring_extraction_end
echo %SUBSTRING%