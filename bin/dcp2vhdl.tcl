if { $argc != 2 } {
    puts "args : <dcpfile> <vhdlfile>"
    exit
    }
set DCPFILE [lindex $argv 0]
set VHDLFILE [lindex $argv 1]
open_checkpoint $DCPFILE
write_xdc -force $VHDLFILE
