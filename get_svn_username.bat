@echo off
setlocal EnableDelayedExpansion

set fileSvnAuth=svn_auth
REM @echo on
svnn auth>%fileSvnAuth%
set /p svnAuthUsername=<%fileSvnAuth%
for /f "eol=- tokens=2 skip=5" %%i in (%fileSvnAuth%) do (
  set svnAuthUsername=%%i
  goto :end_get_svn_auth_username
)
:end_get_svn_auth_username
echo svn auth : svnAuthUsername = !svnAuthUsername!
if "!svnAuthUsername!" == "" (
    set szSvnAuthCachePath=%APPDATA%\Subversion\auth\svn.simple
    echo !szSvnAuthCachePath!
    for /f %%j in ('dir /b !szSvnAuthCachePath!\*.*') do (
        for /f "skip=15" %%i in (!szSvnAuthCachePath!\%%j) do (
            set svnAuthUsername=%%i
            echo !svnAuthUsername!
            goto :end_get_svn_cache_auth_username
        )
    )
)
:end_get_svn_cache_auth_username
echo cache : svnAuthUsername = !svnAuthUsername!