@echo off
set DIR=%~dp0
set FILENAME=the_existent_directory
set FILEPATH=%DIR%%FILENAME%
rem or set FILEPATH=%DIR%\%FILENAME%
if exist %FILEPATH% (
  echo The existent directory "%FILENAME%" has been removed.
  rd /S /Q %FILEPATH%
) else (
  echo The inexistent directory "%FILENAME%" has been created.
  md %FILEPATH%
)
pause 1>nil