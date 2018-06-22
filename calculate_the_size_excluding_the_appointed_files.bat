@echo on
set ORIGIN=%~dp0\..\Lua_files
set DIR1=%~dp0\lua_files_copy_1
set DIR2=%~dp0\lua_files_copy_2
rem 查找ip地址举例
copy %ORIGIN%\*.lua %DIR1%
copy %ORIGIN%\*.lua %DIR2%
set n=0
for /f "delims=" %%i in ('dir /a-d /b %ORIGIN%\*') do (
  for /f "delims=" %%j in ('dir /a-d /b %DIR1%\*') do (
    if %%i == %%j (
	  goto continue_looping
	)
  )
  for /f "delims=" %%k in ('dir /a-d /b %DIR2%\*') do (
    if %%i == %%k (
	  goto continue_looping
	)
  )
  set /a n+=%%~zi
:continue_looping
)
echo/
echo Total size = %n% Bytes

del /q %DIR1%
del /q %DIR2%