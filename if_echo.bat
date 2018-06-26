@echo off
set FILENAME=file_to_be_written
if echo "A string are written into a file.">%FILENAME% (
  echo Write successful.
)
pause 1>nul