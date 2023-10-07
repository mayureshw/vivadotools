# Generates a <ipname>.vhdl file from a given dcp file produced by ipxci2dcp.

if { $argc != 1 } {
    puts "args : <dcpfile>"
    exit
    }
set DCP [lindex $argv 0]
set VHDLNAME [file root [file tail $DCP]]
append VHDLNAME ".vhdl"

open_checkpoint $DCP
write_vhdl $VHDLNAME
