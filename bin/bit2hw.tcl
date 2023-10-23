set TOP  $env(TOP)
set BITSTREAMFILE  $TOP
append BITSTREAMFILE .bit
set FILE2HW $env(VIVADOTOOLSDIR)
append FILE2HW /bin/file2hw.tcl
set argv [list $BITSTREAMFILE]
set argc 1
source $FILE2HW
