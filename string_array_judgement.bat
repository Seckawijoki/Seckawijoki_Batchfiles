@echo off
set FOUND_CN=
:: set a=CN US EN JP
set a=US EN JP
for %%i in (%a%) do   if "%%i" == "CN" 	set FOUND_CN=1
  

if defined FOUND_CN (
  echo Has found CN.
) else (
  echo Has not found CN.
)