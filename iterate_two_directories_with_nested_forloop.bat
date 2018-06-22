@echo off
set DIR1=%~dp0\..\Lua_files
set SUFFIX1=lua
set DIR2=%~dp0\..\CPP_files
set SUFFIX2=cpp
set DIR2=%DIR1%
set SUFFIX2=%SUFFIX1%
for /f "delims=" %%i in ('dir /b %DIR1%\*.%SUFFIX1%') do (
  for /f "delims=" %%j in ('dir /b %DIR2%\*.%SUFFIX2%') do (
    if %%i == %%j (
	  echo O %%i equals to %%j
	) else (
	  echo X %%i doesn't equals to %%j
	)
  )
)
 pause