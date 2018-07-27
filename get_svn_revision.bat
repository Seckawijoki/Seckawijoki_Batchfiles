@echo off

setlocal EnableDelayedExpansion
set fileSvnInfo=svn_info
svn info > %fileSvnInfo%

for /f "tokens=2 skip=6" %%i in (%fileSvnInfo%) do (
  if not defined bGetSvnRevision (
    echo i = %%i
    set svnRevision=%%i
    set bGetSvnRevision=1
  )
  goto :end_get_svn_info
)
:end_get_svn_info
echo svnRevision = %svnRevision%
