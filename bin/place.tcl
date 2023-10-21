set TOP  $env(TOP)
set LASTDCP  $TOP
set DCP  $TOP
append LASTDCP .synth.dcp
append DCP .place.dcp

set PREPLACE "pre-place.tcl"

open_checkpoint $LASTDCP
if [ file exists $PREPLACE ] {
    source $PREPLACE
    }
place_design
write_checkpoint -force $DCP
