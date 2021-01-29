@echo off
setlocal EnableDelayedExpansion

set "aTextureNames=!aTextureNames!,texture0"
set "aTextureNames=!aTextureNames!,texture2"
set "aTextureNames=!aTextureNames!,texture3"
set "aTextureNames=!aTextureNames!,texture4"
set "aTextureNames=!aTextureNames!,texture5"

set "aTextureNames=!aTextureNames:~1!"

for %%i in (!aTextureNames!) do (
    for /f %%j in ('dir /ad /b %%i\*') do (
        echo %%j
        if "%%j" == "outgame2" (
            del %%i\%%j\uitex\*.pvr
            del %%i\%%j\uitex2\*.pvr
            del %%i\%%j\uitex3\*.pvr
            del %%i\%%j\uitex4\*.pvr
            del %%i\%%j\uitex\*.ktx
            del %%i\%%j\uitex2\*.ktx
            del %%i\%%j\uitex3\*.ktx
            del %%i\%%j\uitex4\*.ktx
        ) 
        if not "%%j" == "bigtex" if not "%%j" == "outgame2" (
            del %%i\%%j\*.pvr
            del %%i\%%j\*.ktx
        )
    )
)