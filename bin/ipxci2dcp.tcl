# Generates a .dcp file for the ip which can be used by dcp2vhdl to generate vhdl.
# Such vhdl can be used only for simulation.
# See ipgen for generation of configured IP in the form of xci file.
if { $argc != 1 } {
    puts "args : <xcifile>"
    exit
    }
set XCIFILE [lindex $argv 0]
set PARTNAME $env(PARTNAME)
create_project -in_memory -part $PARTNAME
read_ip $XCIFILE
synth_ip -force [get_ips]
