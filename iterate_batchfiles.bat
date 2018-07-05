@echo off
set SUFFIX=bat
for /f "delims=" %%i in ('dir /s /b *.%SUFFIX%') do (
  echo %%~ni
  if exist %%~ni (
    echo %%~ni exists.
  )
)
for /f "delims=" %%i in ('dir /s /b *.%SUFFIX%') do (
  echo %%~i
)
pause