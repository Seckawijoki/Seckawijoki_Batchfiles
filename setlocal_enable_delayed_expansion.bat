@echo off
setlocal EnableDelayedExpansion
set boolean=true
if "%boolean%" equ "true" (
  set boolean=false
  echo %boolean%
  echo !boolean!
)