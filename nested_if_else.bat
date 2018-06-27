@echo off
set APK_RELEASE=release

if "%APK_RELEASE%" equ "" (
  echo Empty string.
) else (
  if "%APK_RELEASE%" equ "debug" (
    echo Debug.
  ) else (
    if "%APK_RELEASE%" equ "release" (
      echo Release.
    )
  )
)