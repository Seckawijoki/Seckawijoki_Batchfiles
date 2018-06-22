@echo off
set DIRECTORY1=%~dp0\the_existent_directory
set DIRECTORY2=%~dp0\existent_directory
set FILE1=%~dp0\nil
set FILE2=%~dp0\the_existent_file
if exist %DIRECTORY1% (
  echo %DIRECTORY1% exists.
)
if exist %DIRECTORY2% (
  echo %DIRECTORY2% exists.
)
if exist %FILE1% (
  echo %FILE1% exists.
)
if exist %FILE2% (
  echo %FILE2% exists.
)
pause