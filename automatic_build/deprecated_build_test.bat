@echo off

%DRIVE%
cd %mPathProjAndroidAssetsConfusion%

rem ---------- pngquant 2 start ----------
echo ----- pngquant 2 rename -fs8.png files start -----
set renameCountOfPngFiles=0
for /r %%i in (*-fs8.png) do (
  set bTheSameExists=
  for /r %%j in (.\res\*.png) do (
    if %%i == %%j set bTheSameExists=true
  )
  for /r %%j in (.\build\*) do (
    if %%i == %%j set bTheSameExists=true
  )
  for /r %%j in (.\.idea\*) do (
    if %%i == %%j set bTheSameExists=true
  )
  if not defined bTheSameExists (
    set /a renameCountOfPngFiles+=1
    rename %%~nxi %%i-fs8
  )
)
echo ----- pngquant 2 rename %deleteCountOfPngFiles% -fs8.png files end -----

rem ---------- pngquant 3 start ----------
echo ----- pngquant 3 rename -or8.png files start -----
set renameCountOfPngFiles=0
for /r %%i in (*-or8.png) do (
  set bTheSameExists=
  for /r %%j in (.\res\*.png) do (
    if %%i == %%j set bTheSameExists=true
  )
  for /r %%j in (.\build\*) do (
    if %%i == %%j set bTheSameExists=true
  )
  for /r %%j in (.\.idea\*) do (
    if %%i == %%j set bTheSameExists=true
  )
  if not defined bTheSameExists (
    set /a renameCountOfPngFiles+=1
    rename %%~nxi %%i-or8
  )
)
echo ----- pngquant 3 rename %deleteCountOfPngFiles% -or8.png files end -----