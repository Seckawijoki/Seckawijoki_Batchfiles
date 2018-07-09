@echo off

for /f %%i in (' dir /s /b f:\batch_files\*.bat, f:\cpp_files\*.cpp, f:\bash_files\*.sh, f:\lua_files\*.lua ' ) do ( 
  echo %%i 
)
echo end

pause