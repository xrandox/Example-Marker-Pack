::note: .\ gives relative directory -- i.e., the folder the .bat is in

::deletes the old .taco if it exists
::   ".\your-pack.taco"
del ".\ExamplePack.taco"

::this is a bunch of fancy jargon to run WINRAR via command line
::"location of your WINRAR Folder"                           ".\your-pack.zip"   ".\Data"  ".\your-xml.xml"
"%ProgramFiles%\WinRAR\WinRAR.exe" a -afzip -ep1 -ibck -r -y ".\ExamplePack.zip" ".\Data" ".\ExamplePack.xml"

::renames the zip to .taco -- this is mostly for distribution purposes. if left as .zip some people get confused and try to extract the pack
rename "ExamplePack.zip" "ExamplePack.taco"