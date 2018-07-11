@echo off

setlocal EnableDelayedExpansion

set currentPath=%~p0
set currentPath=!currentPath:~0,-1!
echo currentPath = !currentPath!

call :function_getDirectoryName !currentPath!
echo mDirectoryName = !mDirectoryName!

pause

::---------------------------------------------------------------  
::-- Desciption: 
::      Get the directory name.
::-- Param: 
::      The current path substring from 0 to length-1.(To move the last '\')
::-- Global Return: 
::      !mDirectoryName!
::--------------------------------------------------------------- 
:function_getDirectoryName
if "%~1" == "" goto :eof
set tempDirectoryName=%~1
set mDirectoryName=
:loop_start_splitTheDirectoryName
if not "!tempDirectoryName!" == "" (
  set char=!tempDirectoryName:~-1!
  rem echo char = !char!
  if not "!char!" == "\" (
    set mDirectoryName=!tempDirectoryName:~-1!!mDirectoryName!
    set tempDirectoryName=!tempDirectoryName:~0,-1!
    goto :loop_start_splitTheDirectoryName
  ) else (
    goto :eof
  )
)
