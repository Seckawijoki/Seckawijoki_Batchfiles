@echo off
setlocal EnableDelayedExpansion

mode con cols=160 lines=1000

set DIR_ASSETS=assets
set DRIVE=F:
REM set DRIVE=G:
set DIR_TRUNK=trunk
set DIR_ENV=env1
REM set DIR_ENV=env2
REM set DIR_ENV=env3
set PATH_BIN=%DRIVE%\%DIR_TRUNK%\%DIR_ENV%\bin

set "projectList=!projectList! ..\AsAppPlay\"
REM set "projectList=!projectList! Proj.Android.Anzhi"
REM set "projectList=!projectList! Proj.Android.Dangle"
REM set "projectList=!projectList! Proj.Android.Gg"
REM set "projectList=!projectList! Proj.Android.Huawei"
REM set "projectList=!projectList! Proj.Android.Mini"
REM set "projectList=!projectList! Proj.Android.Mini18183"
REM set "projectList=!projectList! Proj.Android.MiniBeta"
REM set "projectList=!projectList! Proj.Android.Oppo"
REM set "projectList=!projectList! Proj.Android.OppoYZ"
REM set "projectList=!projectList! Proj.Android.SougouLLQ"
set "projectList=!projectList! proj.AndroidStudio.Blockark"
REM set "projectList=!projectList! Proj.Android.Oppo"
REM set "projectList=!projectList! Proj.Android.Tencent"
REM set "projectList=!projectList! Proj.Android.Vivo"
REM set "projectList=!projectList:~1!"
echo.
echo projectList = !projectList!

REM set "deleteFileList=!deleteFileList! ui\mobile\texture2\common_icon.ktx"
REM set "deleteFileList=!deleteFileList! ui\mobile\texture2\common_icon_alpha.ktx"
REM set "deleteFileList=!deleteFileList! ui\mobile\texture2\common.ktx"
REM set "deleteFileList=!deleteFileList! ui\mobile\texture2\common_alpha.ktx"
if not "!deleteFileList!" == "" set "deleteFileList=!deleteFileList:~1!"

REM set "luaScriptFileList=!luaScriptFileList! accountcs.lua"
REM set "luaScriptFileList=!luaScriptFileList! client.lua"
REM set "luaScriptFileList=!luaScriptFileList! config.lua"
REM set "luaScriptFileList=!luaScriptFileList! log.lua"
REM set "luaScriptFileList=!luaScriptFileList! print.lua"
REM set "luaScriptFileList=!luaScriptFileList! ui\battle.lua"
REM set "luaScriptFileList=!luaScriptFileList! ui\friendservice.lua"
REM set "luaScriptFileList=!luaScriptFileList! ui\login.lua"
echo.
echo luaScriptFileList = !luaScriptFileList!

REM set "mobileFileList=!mobileFileList! accelkeys.lua"
REM set "mobileFileList=!mobileFileList! account.lua"
REM set "mobileFileList=!mobileFileList! account.xml"
REM set "mobileFileList=!mobileFileList! activity.lua"
REM set "mobileFileList=!mobileFileList! activity.xml"
REM set "mobileFileList=!mobileFileList! activity4399.xml"
REM set "mobileFileList=!mobileFileList! activityMainCtrl.lua"
REM set "mobileFileList=!mobileFileList! activityMainFrame.lua"
set "mobileFileList=!mobileFileList! ad_logic.lua"
REM set "mobileFileList=!mobileFileList! advert.lua"
REM set "mobileFileList=!mobileFileList! anti_addiction.lua"
REM set "mobileFileList=!mobileFileList! AREngine.lua"
REM set "mobileFileList=!mobileFileList! AREngine.xml"
REM set "mobileFileList=!mobileFileList! augmentedreality.lua"
REM set "mobileFileList=!mobileFileList! augmentedreality.xml"
REM set "mobileFileList=!mobileFileList! autojump_fuc.lua"
REM set "mobileFileList=!mobileFileList! blocktransfer.lua"
REM set "mobileFileList=!mobileFileList! blocktransfer.xml"
REM set "mobileFileList=!mobileFileList! backpack.lua"
REM set "mobileFileList=!mobileFileList! battle.lua"
REM set "mobileFileList=!mobileFileList! battle.xml"
REM set "mobileFileList=!mobileFileList! blueprintdrawing.xml"
REM set "mobileFileList=!mobileFileList! craftingtable.lua"
REM set "mobileFileList=!mobileFileList! ChannelReward.lua"
REM set "mobileFileList=!mobileFileList! death.lua"
set "mobileFileList=!mobileFileList! developerstore.lua"
REM set "mobileFileList=!mobileFileList! enchant.xml"
REM set "mobileFileList=!mobileFileList! friend.lua"
REM set "mobileFileList=!mobileFileList! friend.xml"
REM set "mobileFileList=!mobileFileList! friendchat.lua"
REM set "mobileFileList=!mobileFileList! friendservice.lua"
REM set "mobileFileList=!mobileFileList! Fonts.xml"
REM set "mobileFileList=!mobileFileList! game_start.toc"
REM set "mobileFileList=!mobileFileList! game_main.toc"
set "mobileFileList=!mobileFileList! globaldata.lua"
REM set "mobileFileList=!mobileFileList! guide.lua"
REM set "mobileFileList=!mobileFileList! gameruleset.xml"
REM set "mobileFileList=!mobileFileList! homechest.lua"
REM set "mobileFileList=!mobileFileList! homechest.xml"
REM set "mobileFileList=!mobileFileList! http.lua"
REM set "mobileFileList=!mobileFileList! interactive.lua"
REM set "mobileFileList=!mobileFileList! interactive.xml"
REM set "mobileFileList=!mobileFileList! lite.lua"
REM set "mobileFileList=!mobileFileList! loading.lua"
REM set "mobileFileList=!mobileFileList! lobby.lua"
REM set "mobileFileList=!mobileFileList! login.lua"
REM set "mobileFileList=!mobileFileList! login.xml"
REM set "mobileFileList=!mobileFileList! mapservice.lua"
REM set "mobileFileList=!mobileFileList! mapmaterial.xml"
REM set "mobileFileList=!mobileFileList! mapmodellib.lua"
REM set "mobileFileList=!mobileFileList! marketactivity.lua"
REM set "mobileFileList=!mobileFileList! messagebox.lua"
REM set "mobileFileList=!mobileFileList! minilobby.lua"
REM set "mobileFileList=!mobileFileList! minilobby.xml"
REM set "mobileFileList=!mobileFileList! miniworks.lua"
REM set "mobileFileList=!mobileFileList! miniworks.xml"
REM set "mobileFileList=!mobileFileList! mymods_editor.xml"
REM set "mobileFileList=!mobileFileList! playmain.lua"
REM set "mobileFileList=!mobileFileList! PlayerExhibitionCenter.lua"
REM set "mobileFileList=!mobileFileList! PlayerExhibitionCenter.xml"
REM set "mobileFileList=!mobileFileList! playercenter.lua"
REM set "mobileFileList=!mobileFileList! playercenter_new.lua"
REM set "mobileFileList=!mobileFileList! playercenter_new.xml"
REM set "mobileFileList=!mobileFileList! QRCodeScanner.lua"
REM set "mobileFileList=!mobileFileList! room.lua"
REM set "mobileFileList=!mobileFileList! room.xml"
set "mobileFileList=!mobileFileList! selectrole.lua"
REM set "mobileFileList=!mobileFileList! setting.lua"
REM set "mobileFileList=!mobileFileList! setting.xml"
REM set "mobileFileList=!mobileFileList! share.lua"
REM set "mobileFileList=!mobileFileList! share.xml"
REM set "mobileFileList=!mobileFileList! singleeditor.xml"
REM set "mobileFileList=!mobileFileList! skinconfigctrl.lua"
REM set "mobileFileList=!mobileFileList! SpamPrevention.lua"
set "mobileFileList=!mobileFileList! store.lua"
set "mobileFileList=!mobileFileList! store.xml"
REM set "mobileFileList=!mobileFileList! SearchMgr.lua"
REM set "mobileFileList=!mobileFileList! tips.lua"
REM set "mobileFileList=!mobileFileList! uicommon.lua"
REM set "mobileFileList=!mobileFileList! vipqq.lua"
REM set "mobileFileList=!mobileFileList! vipqq.xml"
REM set "mobileFileList=!mobileFileList! uiconfig\uitemplate.xml"
REM set "mobileFileList=!mobileFileList! texture2\common_icon.png"
REM set "mobileFileList=!mobileFileList! texture2\common_icon.xml"
REM set "mobileFileList=!mobileFileList! texture2\common_icon.ktx"
REM set "mobileFileList=!mobileFileList! texture2\common_icon_alpha.ktx"
REM set "mobileFileList=!mobileFileList! texture2\friend.xml"
REM set "mobileFileList=!mobileFileList! texture2\friend.ktx"
REM set "mobileFileList=!mobileFileList! texture2\friend.ktx"
REM set "mobileFileList=!mobileFileList! texture2\common.png"
REM set "mobileFileList=!mobileFileList! texture2\common.xml"
REM set "mobileFileList=!mobileFileList! texture2\vipicon.png"
REM set "mobileFileList=!mobileFileList! texture2\vipicon.xml"
REM set "mobileFileList=!mobileFileList! texture\uitex2\fx_tw.png"
REM set "mobileFileList=!mobileFileList! texture\bigtex_comm\card_default.png"
REM set "mobileFileList=!mobileFileList! texture\uitex.png"
REM set "mobileFileList=!mobileFileList! texture\uitex.xml"
REM set "mobileFileList=!mobileFileList! mvc\developer\editScriptItem\DeveloperEditScriptItemCtrl.lua"
REM set "mobileFileList=!mobileFileList! mvc\developer\editScriptItem\DeveloperEditScriptItemView.lua"
REM set "mobileFileList=!mobileFileList! mvc\developer\editScriptItem\DeveloperEditScriptItemModel.lua"
REM set "mobileFileList=!mobileFileList! mvc\developer\editTriggerItem\DeveloperEditTriggerItem.xml"
REM set "mobileFileList=!mobileFileList! mvc\developer\editTriggerList\DeveloperEditTriggerListCtrl.lua"
REM set "mobileFileList=!mobileFileList! mvc\developer\editTrigger\DeveloperEditTriggerCtrl.lua"
REM set "mobileFileList=!mobileFileList! mvc\developer\editTrigger\DeveloperEditTriggerView.lua"
REM set "mobileFileList=!mobileFileList! mvc\developer\runtimeInfo\DeveloperRuntimeInfoView.lua"
set "mobileFileList=!mobileFileList:~1!"
echo.
echo mobileFileList = !mobileFileList!

REM set "csvFileList=!csvFileList! minicoin.csv"
REM set "csvFileList=!csvFileList! autogen\stringdef.csv"
echo.
echo csvFileList = !csvFileList!


%DRIVE%
cd %DRIVE%\%DIR_TRUNK%\%DIR_ENV%\client\AppPlay\

for %%i in (!projectList!) do (
    echo.
    echo --------------------------------------------------------------------------------------------------------------------------------
    echo %%i
    set project=%%i
    for %%j in (!deleteFileList!) do (
        del /q /s !project!\assets\%%j
    )
    for %%j in (!luaScriptFileList!) do (
        if exist !project!\assets\luascript\%%j ( echo y | xcopy /d %PATH_BIN%\res\luascript\%%j !project!\assets\luascript\%%j )
        if not exist !project!\assets\luascript\%%j (  copy %PATH_BIN%\res\luascript\%%j !project!\assets\luascript\%%j )
    )
    for %%j in (!mobileFileList!) do (
        if exist !project!\assets\ui\mobile\%%j  ( echo y | xcopy /d %PATH_BIN%\res\ui\mobile\%%j !project!\assets\ui\mobile\%%j )
        if not exist !project!\assets\ui\mobile\%%j (  copy %PATH_BIN%\res\ui\mobile\%%j !project!\assets\ui\mobile\%%j )
        REM copy %PATH_BIN%\res\ui\mobile\%%j !project!\assets\ui\mobile\%%j
    )
    for %%j in (!csvFileList!) do (
        if exist !project!\assets\csvdef\%%j (  echo y | xcopy /d %PATH_BIN%\res\csvdef\%%j !project!\assets\csvdef\%%j )
        if not exist !project!\assets\csvdef\%%j (  copy %PATH_BIN%\res\csvdef\%%j !project!\assets\csvdef\%%j )
    )

    REM echo a | xcopy /s /e /a /c /q %PATH_BIN%\res\overseas_res\* !project!\assets\overseas_res\
    REM copy %PATH_BIN%\res\overseas_res\english\fonts\Fonts.xml !project!\assets\ui\mobile\Fonts.xml
)
REM echo a | xcopy /s /e /a /c /q /d %PATH_BIN%\res\luascript\*.lua !project!\assets\luascript\
REM echo a | xcopy /d %PATH_BIN%\res\ui\mobile\*.lua !project!\assets\ui\mobile\
REM echo a | xcopy /d %PATH_BIN%\res\ui\mobile\*.xml !project!\assets\ui\mobile\
pause