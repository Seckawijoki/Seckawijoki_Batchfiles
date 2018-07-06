@echo off
setlocal EnableDelayedExpansion
set A_PATHS_BATCH_FILE=

for /r %%i in (*.bat) do (
  echo !A_PATHS_BATCH_FILE!
  set "A_PATHS_BATCH_FILE=!A_PATHS_BATCH_FILE! %%i"
)
pause
for %%i in (!A_PATHS_BATCH_FILE!) do echo %%i