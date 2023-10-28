if { $argc != 2 } {
    puts "args : <dcpfile> <xdcfile>"
    exit
    }
set DCPFILE [lindex $argv 0]
set XDCFILE [lindex $argv 1]
open_checkpoint $DCPFILE
write_xdc -force $XDCFILE
