@echo off
set android_manifest_xml_file=AndroidManifest.xml
if not exist %android_manifest_xml_file% (
  copy F:\Miniworld_projects\client\AppPlay\Proj.Android.MiniBeta\%android_manifest_xml_file% .\%android_manifest_xml_file%
)