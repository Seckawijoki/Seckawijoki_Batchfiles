@echo off
set DIR=%~dp0\files_to_be_deleted
set FILENAME=%DIR%\to_be_deleted_file
set count=50
set i=0
if not exist %DIR% do (
  md %DIR%
)
:file_creating_loop_start
if %i% lss %count% ( 
  echo %i%>%FILENAME%%i%
  set /A i=%i%+1
  goto file_creating_loop_start
)
:file_creating_loop_end
