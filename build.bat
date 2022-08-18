:: You must replace YOUR PACKS NAME and YOUR XMLS NAME in order to use
:: ex: del ".\TehsTrails.taco"

:: deletes existing pack
del ".\<YOUR PACKS NAME>.taco"

:: uses WinRar to create a zip out of \Data and \YOUR XML
"%ProgramFiles%\WinRAR\WinRAR.exe" a -afzip -ep1 -ibck -r -y ".\<YOUR PACKS NAME>.zip" ".\Data" ".\<YOUR XMLS NAME>.xml"

:: renames the zip to taco
rename "<YOUR PACKS NAME>.zip" "<YOUR PACKS NAME>.taco"
