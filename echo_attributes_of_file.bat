@echo off
if "%~1" == "" (
  echo path name:
  echo %0
  echo fully qualified path name:
  echo %~f0
  echo dirive:
  echo %~d0
  echo path:
  echo %~p0
  echo name:
  echo %~n0
  echo extention:
  echo %~x0
  echo short name:
  echo %~s0
  echo attribute:
  echo %~a0
  echo time:
  echo %~t0
  echo size:
  echo %~z0
  echo directory:
  echo %~dp0
) else (
  echo path name:
  echo %1
  echo fully qualified path name:
  echo %~f1
  echo dirive:
  echo %~d1
  echo path:
  echo %~p1
  echo name:
  echo %~n1
  echo extention:
  echo %~x1
  echo short name:
  echo %~s1
  echo attribute:
  echo %~a1
  echo time:
  echo %~t1
  echo size:
  echo %~z1
  echo directory:
  echo %~dp1

)
