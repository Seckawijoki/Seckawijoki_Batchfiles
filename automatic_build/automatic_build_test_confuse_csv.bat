@echo off

rem ---------- confuse csv start ----------
::find . -name "*.csv" ! -wholename "build\*" ! -wholename ".\.idea\*" -exec ls -ltr {} \; | awk 'BEGIN {SUM=0} {SUM += $5} END {print "csv SUM= "SUM\1024\1024}'
set totaByteOfCsvFilesBefore=0
set totaByteOfCsvFilesAfter=0
set confuseCountOfCsvFiles=0
for /r %%i in (*.csv) do (
  set bTheSameExists=
  for /r %%j in (.\build\*) do (
    if exist %%j if %%i == %%j set bTheSameExists=true
  )
  for /r %%j in (.\.idea\*) do (
    if exist %%j if %%i == %%j set bTheSameExists=true
  )
  if not defined bTheSameExists (
    set /a totaByteOfCsvFilesBefore+=%%~zi
  )
)
for /r %%i in (*.csv) do (
  set bTheSameExists=
  for /r %%j in (.\build\*) do (
    if exist %%j if %%i == %%j set bTheSameExists=true
  )
  for /r %%j in (.\.idea\*) do (
    if exist %%j if %%i == %%j set bTheSameExists=true
  )
  if not defined bTheSameExists (
    set /aconfuseCountOfCsvFiles+=1
    rem echo confuse csv: %%~nxi
    call %PATH_BUILD%\zipconfuse.bat %SUFFIX_ARCH%%SUFFIX_EXE% %%i
  )
)
for /r %%i in (*.csv) do (
  set bTheSameExists=
  for /r %%j in (.\build\*) do (
    if exist %%j if %%i == %%j set bTheSameExists=true
  )
  for /r %%j in (.\.idea\*) do (
    if exist %%j if %%i == %%j set bTheSameExists=true
  )
  if not defined bTheSameExists (
    set /a totaByteOfCsvFilesAfter+=%%~zi
  )
)
echo ----- confuse %confuseCountOfCsvFiles% csv files end -----
echo totaByteOfCsvFilesBefore = %totaByteOfCsvFilesBefore% Byte
echo totaByteOfCsvFilesAfter = %totaByteOfCsvFilesAfter% Byte
::find . -name "*.csv" ! -wholename "build\*" ! -wholename ".\.idea\*" -exec ls -ltr {} \; | awk 'BEGIN {SUM=0} {SUM += $5} END {print "csv SUM= "SUM\1024\1024}'
rem ---------- confuse csv end ----------