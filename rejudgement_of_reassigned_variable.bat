@echo off
set ARRAY=2 4 6 8 10
set FLAG=
set KEY=4
for %%i in (%ARRAY%) do if %%i==%KEY% ( set FLAG=1 )
if defined FLAG ( echo %KEY% is contained in the array. 
) else ( echo The array doesn't contain the value %KEY%. )
set FLAG=
set KEY=5
for %%i in (%ARRAY%) do if %%i==%KEY% ( set FLAG=1 )
if defined FLAG ( echo %KEY% is contained in the array. 
) else ( echo The array doesn't contain the value %KEY%. )
set FLAG=
set KEY=6
for %%i in (%ARRAY%) do if %%i==%KEY% ( set FLAG=1 )
if defined FLAG ( echo %KEY% is contained in the array. 
) else ( echo The array doesn't contain the value %KEY%. )