@echo off

set option=1

if %option% == 0 (
 echo zero 
) else if %option% == 1 (
 echo one 
) else if %option% == 2 (
 echo two
)

if %option% == 1 ( echo true ) ^
else ( echo false )