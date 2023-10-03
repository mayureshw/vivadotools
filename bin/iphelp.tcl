create_project -in_memory
if { $argc != 1 } {
    puts "Pass vlnv string of the ip as an argument"
    exit
    }
create_ip -vlnv [lindex $argv 0] -module_name iphelp
puts [report_property -all [get_ips]]
