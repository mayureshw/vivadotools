set TOP  $env(TOP)
set LASTDCP  $TOP
set DCP  $TOP
append LASTDCP .place.dcp
append DCP .route.dcp

open_checkpoint $LASTDCP
route_design
write_checkpoint -force $DCP
