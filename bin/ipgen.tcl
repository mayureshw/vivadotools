# For using the ips, use the xci file generated into your SRCS variable in
# your Makefile. Do not move the xci file as Vivado seems fussy about its
# location

if { $argc < 3 } {
    puts "args : <ip vlnv> <supported target> <modulename> \[ {param val}...\] (see iphelp)"
    exit
    }
set VLNV [lindex $argv 0]
set TGT [lindex $argv 1]
set MODULE [lindex $argv 2]
set IPSRCDIR "ipsrc"
file mkdir $IPSRCDIR
create_project -in_memory
create_ip -dir $IPSRCDIR -force -vlnv $VLNV -module_name $MODULE
set PROPVALS [lrange $argv 3 end]
if { $argc > 3 } {
    set_property -dict "$PROPVALS" [get_ips]
}
generate_target -force $TGT [get_ips]
