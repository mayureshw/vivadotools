# Preferably run this script in a clean directory to see what it generated
if { $argc < 3 } {
    puts "args : <ip vlnv> <supported target> <modulename> \[ {param val}...\] (see iphelp)"
    exit
    }
set VLNV [lindex $argv 0]
set TGT [lindex $argv 1]
set MODULE [lindex $argv 2]
create_project -in_memory
create_ip -vlnv $VLNV -module_name $MODULE
set PROPVALS [lrange $argv 3 end]
if { $argc > 3 } {
    set_property -dict "$PROPVALS" [get_ips]
}
generate_target $TGT [get_ips]
