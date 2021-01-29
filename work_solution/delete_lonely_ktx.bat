@echo off
setlocal EnableDelayedExpansion

for /r . %%i in (*.ktx) do (
    set szFilePath=%%i
    set szKtxFileNameEnd=!szFilePath:~-10!
    if "!szKtxFileNameEnd!" == "_alpha.ktx" (
        set szFilePurePath=!szFilePath:~,-10!
        set szPngPurePath=!szFilePurePath!.png
        set szKtxAlphaPath=!szFilePath!
        set szKtxPath=!szFilePurePath!.ktx
    ) else (
        set szFilePurePath=%%~ndpi
        set szPngPurePath=!szFilePurePath!.png
        set szKtxAlphaPath=!szFilePurePath!_alpha.ktx
        set szKtxPath=!szFilePath!
    )
    if not exist !szPngPurePath! (
        if exist !szKtxPath! (
            echo !szKtxPath!
            del !szKtxPath!
        )
        if exist !szKtxAlphaPath! (
            echo !szKtxAlphaPath!
            del !szKtxAlphaPath!
        )
    )
)