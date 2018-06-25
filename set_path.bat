@echo on
set p=%~dp0
echo %p%
set p=%p%\..\Lua_files
echo %p%
set f=%p%\..\batchfiles\set_path.bat
echo %f%
type %f%
copy %f% %p%\set_path.txt
type %p%\set_path.txt