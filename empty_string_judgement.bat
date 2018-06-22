@echo off
if "%0%" equ "" (
  echo The string is empty.
) else (
  echo The string is %0%.
)
if "%1%" == "" (
  echo The string is empty.
) else (
  echo The string is %1%.
)

if "%2%" neq "" (
  echo The string is not empty.
) else (
  echo The string is empty.
)
