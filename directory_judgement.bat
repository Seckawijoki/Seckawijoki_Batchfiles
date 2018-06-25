@echo off

for /f "delims=" %%i in ('dir /a/b/s *.bat') do (
  pushd "%%i" 2>nul && ( call :folder "%%i" & popd ) || call :file "%%i"
)
    pause
goto :eof
 
:file
    echo %~1 is a file.
goto :eof
 
:folder
    echo %~1 is a directory.
goto :eof
