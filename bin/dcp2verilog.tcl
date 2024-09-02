if { $argc != 2 } {
    puts "args : <dcpfile> <verilogfile>"
    exit
    }
set DCPFILE [lindex $argv 0]
set VERILOGFILE [lindex $argv 1]
open_checkpoint $DCPFILE
write_verilog -force $VERILOGFILE
