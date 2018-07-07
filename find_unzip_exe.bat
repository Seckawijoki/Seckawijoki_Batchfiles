@echo off

rem ----- incomplete -----
set suffixExe=exe
set fileSearched=unzip.exe
for %%c in (A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z) do (
  if exist %%c: (
    echo Drive %%c: exists.
    set drive=%%c:
    %drive%
    for /r %%i in (*.*) do (
      echo %%i
      if "%%~nxi" == "%fileSearched%" (
        echo %%i exists.
        goto :end
      )
    )
  )
)
:end
echo Finished.