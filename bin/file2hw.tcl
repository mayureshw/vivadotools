if { $argc != 1 } {
    puts "args : <bin or bit file>"
    exit
    }
set BITSTREAMFILE [lindex $argv 0]
open_hw_manager
connect_hw_server
open_hw_target
set_property PROGRAM.FILE $BITSTREAMFILE [current_hw_device]
program_hw_devices
