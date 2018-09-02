@echo off

set array=0,1,2,3,4,5,6,7,8,9,A,B,C,D,E,F

for %%i in (%array%) do (
  for %%j in (%array%) do (
    color %%i%%j
    pause
  )
)