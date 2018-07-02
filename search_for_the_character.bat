@echo off
setlocal EnableDelayedExpansion
set string=abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyz
set key_char=l
set first_index=
set last_index=
call :search_for_first_index %string% %key_char%
call :search_for_last_index %string% %key_char%
if !first_index! geq 0 (
  echo The first index of "%key_char%" in the string "%string%" is !first_index!.
) else (
  echo Cannot get the char "%key_char%" in the string "%string%".
)
if !last_index! geq 0 (
  echo The last index of "%key_char%" in the string "%string%" is !last_index!.
) else (
  echo Cannot get the char "%key_char%" in the string "%string%".
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
set /a index=-1
set /a string_length=0
call :get_length_of_string !temp_string!
echo string_length = !string_length!
if !string_length! leq 0 (
  set /a first_index=-1
  goto :eof
)
set /a index=0
:first_character_search_loop
if not "!temp_string!" == "" (
  echo temp_string = !temp_string!
  if "!temp_string:~0,1!" == "%key%" (
    set /a first_index=!index!
    goto :eof
  )
  set temp_string=!temp_string:~1!
  set /a index+=1
  goto first_character_search_loop
)
set /a first_index=-1
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
set /a index=0
set /a string_length=0
call :get_length_of_string !temp_string!
echo string_length = !string_length!
if string_length leq 0 goto :eof
set /a index=string_length-1
:last_character_search_loop
if not "!temp_string!" == "" (
  echo temp_string = !temp_string!
  if "!temp_string:~-1!" == "!key!" (
    set last_index=!index!
    goto :eof
  )
  set temp_string=!temp_string:~0,-1!
  set /a index-=1
  goto last_character_search_loop
)
set last_index=-1
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
set count_string=%~1
set /a string_length=0
if "!count_string!" == "" goto :eof
set /a string_length=1
:string_length_loop
if not "!count_string:~1!" == "" (
  set /a string_length+=1
  set count_string=!count_string:~1!
  goto :string_length_loop
)
goto :eof
