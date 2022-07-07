:: You must replace YOUR PACKS NAME and YOUR XMLS NAME in order to use

del ".\<YOUR PACKS NAME>.taco"

"%ProgramFiles%\WinRAR\WinRAR.exe" a -afzip -ep1 -ibck -r -y ".\<YOUR PACKS NAME>.zip" ".\Data" ".\<YOUR XMLS NAME>.xml"

rename "<YOUR PACKS NAME>.zip" "<YOUR PACKS NAME>.taco"
