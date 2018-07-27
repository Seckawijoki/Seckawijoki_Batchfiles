@echo off

set pathDeleted=F:\trunk\env2\client\AppPlay\Backup_automatic_build_original\assets_ProjAndroidMiniBeta_20180714_173855

forfiles /p "%pathDeleted%" /s /m *.* /d -4 /c "cmd /c del /q @path"
forfiles /p "%pathDeleted%" /s /m * /d -4 /c "cmd /c if "@isdir" == "TRUE" rd /q /s @path"
