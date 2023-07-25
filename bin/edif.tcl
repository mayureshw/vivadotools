set TOP  $env(TOP)
set LASTDCP  $TOP
set DCP  $TOP
append LASTDCP .route.dcp
append DCP .edif

create_project -in_memory
open_checkpoint $LASTDCP
write_edif -force $DCP
