# Preferably run this script in a clean directory to see what it generated
if { $argc != 2 } {
    puts "args : <ip vlnv> <supported target> \[ {param val}...\] (see iphelp)"
    exit
    }
set VLNV [lindex $argv 0]
set TGT [lindex $argv 1]
create_project -in_memory
create_ip -vlnv $VLNV -module_name utestip
set PROPVALS [lrange $argv 1 end]
if { $argc > 2 } {
    set_property -dict "$PROPVALS" [get_ips]
}
generate_target $TGT [get_ips]
