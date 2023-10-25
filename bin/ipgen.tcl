# For using the ips, use the xci file generated into your SRCS variable in
# your Makefile. Do not move the xci file as Vivado seems fussy about its
# location

if { $argc < 2 } {
    puts "args : <ip vlnv> <modulename> \[ {param val}...\] (see iphelp)"
    exit
    }
set TGT all
set VLNV [lindex $argv 0]
set MODULE [lindex $argv 1]
set PARTNAME $env(PARTNAME)
set IPSRCDIR "ipsrc"
file mkdir $IPSRCDIR
create_project -in_memory -part $PARTNAME
create_ip -dir $IPSRCDIR -force -vlnv $VLNV -module_name $MODULE
set PROPVALS [lrange $argv 2 end]
if { $argc > 2 } {
    set_property -dict "$PROPVALS" [get_ips]
}
generate_target -force $TGT [get_ips]
