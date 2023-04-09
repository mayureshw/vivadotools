set TOP  $env(TOP)
set LASTDCP  $TOP
set DCP  $TOP
append LASTDCP .synth.dcp
append DCP .place.dcp

open_checkpoint $LASTDCP
place_design
write_checkpoint -force $DCP
