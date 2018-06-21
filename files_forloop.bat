@echo off
set files = *.bat
for %%a in (%files%) do (
  type %%a
)
 pause 1>nil