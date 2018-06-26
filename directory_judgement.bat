@echo off

for /f "delims=" %%i in ('dir /a/b/s *.bat') do (
  pushd "%%i" 2>nul && ( call :folder "%%i" & popd ) || call :file "%%i"
)
goto :eof
 
:file
    echo FILE: %~1
goto :eof
 
:folder
    echo DIRECTORY: %~1
goto :eof
