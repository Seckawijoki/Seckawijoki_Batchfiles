@echo off
call create_files_to_be_deleted.bat
set DIR=%~dp0\files_to_be_deleted
set FILENAME=%DIR%\to_be_deleted_file
:: 删除文件夹下面的文件，移除确认提示，需要加/Q参数
del /Q %DIR%

set SPECIAL_FILENAME=%DIR%\special_file_to_be_deleted
echo 0>%SPECIAL_FILENAME%
del %SPECIAL_FILENAME%
pause