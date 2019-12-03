@echo off
setlocal EnableDelayedExpansion

set "aTextureFolderNames=texture2 texture3 texture4"
set szToolPath=D:\TexturePacker\bin\TexturePacker.exe
set aCommitPaths=

REM 需要打的贴图，打开注释再运行

REM 2
REM set "a256FolderNames=!a256FolderNames! backpack"
REM set "a256FolderNames=!a256FolderNames! friend"

REM 14
set "a512FolderNames=!a512FolderNames! common_icon"
REM set "a512FolderNames=!a512FolderNames! emoticon"
REM set "a512FolderNames=!a512FolderNames! ingame"
REM set "a512FolderNames=!a512FolderNames! messagebox"
REM set "a512FolderNames=!a512FolderNames! minilobby"
REM set "a512FolderNames=!a512FolderNames! miniwork"
REM set "a512FolderNames=!a512FolderNames! modlib"
REM set "a512FolderNames=!a512FolderNames! noviceguide"
REM set "a512FolderNames=!a512FolderNames! playercenter"
REM set "a512FolderNames=!a512FolderNames! room"
REM set "a512FolderNames=!a512FolderNames! terrainedit"
REM set "a512FolderNames=!a512FolderNames! videotape"
REM set "a512FolderNames=!a512FolderNames! vehicle"
REM set "a512FolderNames=!a512FolderNames! vipicon"

REM 8
REM set "a1024FolderNames=!a1024FolderNames! achievement"
set "a1024FolderNames=!a1024FolderNames! common"
REM set "a1024FolderNames=!a1024FolderNames! homechest"
REM set "a1024FolderNames=!a1024FolderNames! ingame2"
REM set "a1024FolderNames=!a1024FolderNames! old_operateframe"
REM set "a1024FolderNames=!a1024FolderNames! operate"
REM set "a1024FolderNames=!a1024FolderNames! outgame"
REM set "a1024FolderNames=!a1024FolderNames! shop"

REM 2
REM set "a512Outgame2FolderNames=!a512Outgame2FolderNames! uitex"
REM set "a512Outgame2FolderNames=!a512Outgame2FolderNames! uitex2"

REM 2
REM set "a1024Outgame2FolderNames=!a1024Outgame2FolderNames! uitex3"
REM set "a1024Outgame2FolderNames=!a1024Outgame2FolderNames! uitex4"

set paramsCommon=--format xml --max-size 2048 --shape-padding 2 --border-padding 2 --disable-rotation --algorithm MaxRects --no-trim --dither-fs-alpha

set paramsPng=--opt RGBA8888
set paramsPvr=--opt PVRTC4

set paramsWidthHeight256=--width 256 --height 256
set paramsWidthHeight512=--width 512 --height 512
set paramsWidthHeight1024=--width 1024 --height 1024

for %%i in (%aTextureFolderNames%) do (
    cd %%i
    for %%j in (!a256FolderNames!) do (
        %szToolPath% %%j %paramsCommon% %paramsPng% %paramsWidthHeight256% --sheet ./%%j.png --data ./%%j.xml
        echo.
        %szToolPath% %%j %paramsCommon% %paramsPvr% %paramsWidthHeight256% --sheet ./%%j.pvr --data ./__tmp__%%j.xml
        echo.
        set "aCommitPaths=!aCommitPaths!*%%i/%%j.png"
        set "aCommitPaths=!aCommitPaths!*%%i/%%j.xml"
        set "aCommitPaths=!aCommitPaths!*%%i/%%j.pvr"
    )
    for %%j in (!a512FolderNames!) do (
        %szToolPath% %%j %paramsCommon% %paramsPng% %paramsWidthHeight512% --sheet ./%%j.png --data ./%%j.xml
        echo.
        %szToolPath% %%j %paramsCommon% %paramsPvr% %paramsWidthHeight512% --sheet ./%%j.pvr --data ./__tmp__%%j.xml
        echo.
        set "aCommitPaths=!aCommitPaths!*%%i/%%j.png"
        set "aCommitPaths=!aCommitPaths!*%%i/%%j.xml"
        set "aCommitPaths=!aCommitPaths!*%%i/%%j.pvr"
    )
    for %%j in (!a1024FolderNames!) do (
        %szToolPath% %%j %paramsCommon% %paramsPng% %paramsWidthHeight1024% --sheet ./%%j.png --data ./%%j.xml
        echo.
        %szToolPath% %%j %paramsCommon% %paramsPvr% %paramsWidthHeight1024% --sheet ./%%j.pvr --data ./__tmp__%%j.xml
        echo.
        set "aCommitPaths=!aCommitPaths!*%%i/%%j.png"
        set "aCommitPaths=!aCommitPaths!*%%i/%%j.xml"
        set "aCommitPaths=!aCommitPaths!*%%i/%%j.pvr"
    )
    del /q __tmp__*.xml

    cd outgame2
    for %%j in (!a512Outgame2FolderNames!) do (
        %szToolPath% %%j %paramsCommon% %paramsPng% %paramsWidthHeight512% --sheet ./%%j.png --data ./%%j.xml
        echo.
        %szToolPath% %%j %paramsCommon% %paramsPvr% %paramsWidthHeight512% --sheet ./%%j.pvr --data ./__tmp__%%j.xml
        echo.
        set "aCommitPaths=!aCommitPaths!*%%i/%%j.png"
        set "aCommitPaths=!aCommitPaths!*%%i/%%j.xml"
        set "aCommitPaths=!aCommitPaths!*%%i/%%j.pvr"
    )
    for %%j in (!a1024Outgame2FolderNames!) do (
        %szToolPath% %%j %paramsCommon% %paramsPng% %paramsWidthHeight1024% --sheet ./%%j.png --data ./%%j.xml
        echo.
        %szToolPath% %%j %paramsCommon% %paramsPvr% %paramsWidthHeight1024% --sheet ./%%j.pvr --data ./__tmp__%%j.xml
        echo.
        set "aCommitPaths=!aCommitPaths!*%%i/%%j.png"
        set "aCommitPaths=!aCommitPaths!*%%i/%%j.xml"
        set "aCommitPaths=!aCommitPaths!*%%i/%%j.pvr"
    )
    del /q __tmp__*.xml
    cd ..
    cd ..
)

set aCommitPaths=!aCommitPaths:~1!
TortoiseProc.exe /command:commit /path:"!aCommitPaths!"