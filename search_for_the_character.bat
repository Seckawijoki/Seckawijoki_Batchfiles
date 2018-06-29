@echo off
setlocal EnableDelayedExpansion
set string=abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyz
set key_char=z
set first_index=
set last_index=
call :search_for_first_index %string% %key_char%
if !first_index! geq 0 (
  echo The first index of %key_char% in the string %string% is !first_index!.
)

::---------------------------------------------------------------  
::-- Desciption: 
::      Search for the character in the string shown first time from left.
::-- Param: 
::      %~1: the string
::      %~2: the searched character
::-- Global Return: 
::      !first_index!
::--------------------------------------------------------------- 
:search_for_first_index
if "%~1" == "" goto :eof
if "%~2" == "" goto :eof
set temp_string=%~1
set key=%~2
set index=0
:first_character_search_loop
if not !temp_string! == "" (
  if "!temp_string:~0,1!" == "%key%" (
    set first_index=!index!
    goto :eof
  )
  set temp_string=!temp_string:~1!
  set /a index+=1
  goto first_character_search_loop
)
if 
set first_index=-1
goto :eof
::---------------------------------------------------------------  
::-- Desciption: 
::      Search for the character in the string shown first time from right.
::-- Param: 
::      %~1: the string
::      %~2: the searched character
::-- Global Return: 
::      !last_index!
::--------------------------------------------------------------- 
:search_for_last_index
if "%~1" == "" goto :eof
if "%~2" == "" goto :eof
set temp_string=%~1
set key=%~2
set index=0
:character_search_loop
if not !temp_string! == "" (
  if "!temp_string:~-1!" == "%key%" (
    set first_index=!index!
    goto :eof
  )
  set temp_string=!temp_string:~-1!
  set /a index+=1
)
set first_index=-1
goto :eof


::---------------------------------------------------------------  
::-- Desciption: 
::      Count the length of string.
::-- Param: 
::      %~1: the string
::-- Global Return: 
::      !string_length!
::--------------------------------------------------------------- 
:get_length_of_string
if "%~1" == "" goto :eof
set temp_string=%~1
