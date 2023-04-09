set TOP  $env(TOP)
set BITSTREAMFILE  $TOP
append BITSTREAMFILE .bit
open_hw
connect_hw_server
# This is not found to be necessary, though in its absence if sometimes
# says "target not connected", but still transfers the bistream
open_hw_target
set_property PROGRAM.FILE $BITSTREAMFILE [current_hw_device]
program_hw_devices
