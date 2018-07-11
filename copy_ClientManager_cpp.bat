@echo off
set fileClientManagerCpp=ClientManager.Cpp
if not exist %fileClientManagerCpp% (
  copy F:\trunk\Miniworld_projects\client\iworld\%fileClientManagerCpp% .\%fileClientManagerCpp%
)