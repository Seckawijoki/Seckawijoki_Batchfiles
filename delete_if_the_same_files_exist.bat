@echo off
set ORIGIN_DIR=%~dp0\..\Lua_files
set DIR1=%~dp0\lua_files_copy_1
set DIR2=%~dp0\lua_files_copy_2
set SUFFIX=lua
if not exist %DIR1% do (
  md %DIR1%
)
if not exist %DIR2% do (
  md %DIR2%
)
copy %ORIGIN_DIR%\*.%SUFFIX% %DIR1%
copy %ORIGIN_DIR%\*.%SUFFIX% %DIR2%

for /f "delims=" %%i in ('dir /b %DIR1%\*.%SUFFIX%') do (
  for /f "delims=" %%j in ('dir /b %DIR2%\*.%SUFFIX%') do (
	echo %%i COMPARED TO %%j
    if %%i == %%j (
	  echo %DIR1% contains %%i, start to delete %DIR2%\%%j.
	  :: 必须加上路径来指定%%j参数指定的文件
	  del %%j
	) else (
	  echo ----- continue -----
	)
  )
)

del /Q %DIR1%
del /Q %DIR2%