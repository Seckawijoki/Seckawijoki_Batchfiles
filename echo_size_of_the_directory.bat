@echo off

echo %~0
echo The size of the directory: %~z0 byte.
set dirBatchFiles=f:\batch_files

for /f %%i in ('dir f:\*') do (
  echo %%~i : %%~zi
)
pause