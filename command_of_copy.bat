@echo off
set DIR=%~dp0
set COPY_FROM_DIR=%DIR%\files_copied
set COPY_TO_DIR=%DIR%\files_be_copied_to
set COPY_FROM_FILENAME=be_copied_out
set COPY_TO_FILENAME=be_copied_to
set COPY_FROM_FILEPATH=%COPY_FROM_DIR%\%COPY_FROM_FILENAME%
set COPY_TO_FILEPATH=%COPY_TO_DIR%\%COPY_TO_FILENAME%
set INEXISTENT_COPY_TO_FILENAME=inexsitent_file_to_be_copied_to
set INEXISTENT_COPY_TO_FILEPATH=%COPY_TO_DIR%\%INEXISTENT_COPY_TO_FILENAME%
if not exist %COPY_FROM_DIR% (
  md %COPY_FROM_DIR%
)
echo The output file content to be copied.>%COPY_FROM_FILEPATH%
if not exist %COPY_TO_DIR% (
  md %COPY_TO_DIR%
)
echo EMPTY>%COPY_TO_FILEPATH%
echo ----- Before copying, the file to be copied -----
echo/
type %COPY_FROM_FILEPATH%
echo ----- Before copying, the file to be copied into -----
echo/
type %COPY_TO_FILEPATH%
echo ----- START COPYING -----
copy %COPY_FROM_FILEPATH% %COPY_TO_FILEPATH%
echo ----- END COPYING ------
echo ----- After copying, the file to be copied -----
echo/
type %COPY_FROM_FILEPATH%
echo ----- After copying, the file to be copied into -----
echo/
type %COPY_TO_FILEPATH%
echo/
type %INEXISTENT_COPY_TO_FILEPATH% 
copy %COPY_FROM_FILEPATH% %INEXISTENT_COPY_TO_FILEPATH%
type %INEXISTENT_COPY_TO_FILEPATH% 
del %INEXISTENT_COPY_TO_FILEPATH% 
pause
