# This is separated from ipgen, beause of deprection warning for targte example
# Note: will result in error if example is not supported by ip
if { $argc < 2 } {
    puts "args : <ip vlnv> <modulename> \[ {param val}...\] (see iphelp)"
    exit
    }
set VLNV [lindex $argv 0]
set MODULE [lindex $argv 1]
set PARTNAME $env(PARTNAME)
set IPEXAMPLESDIR "ipexamples"
file mkdir $IPEXAMPLESDIR
create_project -in_memory -part $PARTNAME
create_ip -dir $IPEXAMPLESDIR -force -vlnv $VLNV -module_name $MODULE
set PROPVALS [lrange $argv 2 end]
if { $argc > 2 } {
    set_property -dict "$PROPVALS" [get_ips]
}
open_example_project -force -dir $IPEXAMPLESDIR -in_process [get_ips]
