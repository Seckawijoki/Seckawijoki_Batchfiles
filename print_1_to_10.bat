@echo off
set n=0
for /L %%i in (1,1,10) do (
  set /a n=%%n+1
  echo %%i and %%n
)