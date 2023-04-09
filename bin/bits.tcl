set TOP  $env(TOP)
set LASTDCP  $TOP
set DCP  $TOP
append LASTDCP .route.dcp
append DCP .bits

open_checkpoint $LASTDCP
write_bitstream -force $DCP
