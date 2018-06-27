@echo off

for /f "delims=" %%i in ('dir /a/b/s *.bat') do (
  pushd "%%i" 2>nul && ( call :is_a_folder "%%i" & popd ) || call :is_a_file "%%i"
)
goto :eof

 ::---------------------------------------------------------------  
::-- Desciption: 
::      The operation executed if the parameter is a file.
::-- Param: a file path
::-- Global Return: nul
::--------------------------------------------------------------- 
:is_a_file
    echo FILE: %~1
goto :eof
 
 ::---------------------------------------------------------------  
::-- Desciption: 
::      The operation executed if the parameter is a directory.
::-- Param: a file path
::-- Global Return: nul
::--------------------------------------------------------------- 
:is_a_folder
    echo DIRECTORY: %~1
goto :eof
