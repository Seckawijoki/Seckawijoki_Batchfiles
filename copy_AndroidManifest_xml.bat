@echo off
set fileAndroidManifestXml=AndroidManifest.xml
if not exist %fileAndroidManifestXml% (
  copy F:\trunk\Miniworld_projects\client\AppPlay\Proj.Android.MiniBeta\%fileAndroidManifestXml% .\%fileAndroidManifestXml%
)