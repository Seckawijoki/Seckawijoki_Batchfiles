@echo off
rem ----- incomplete -----
set suffixExe=exe
set fileSearched=java.exe
for %%c in (A,B,C,D,E,F,G,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z) do (
  echo %%c:
  if exist %%c: (
    echo Drive %%c: exists.
    set drive=%%c:
    echo drive = %drive%
    %drive%
    for /r %%i in (%drive%\*.exe) do (
      echo %%i
      if "%%~nxi" == "%fileSearched%" (
        echo %%i exists.
        set pathJre=%%~dpi\..
        goto :end
      )
    )
  )
)
:end
echo pathJre = %pathJre%
if not "%pathJre%" == "" (
  set PATH=%PATH%;%pathJre%\bin;%pathJre%\jre\bin
)
echo Finished.