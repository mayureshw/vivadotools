if { $argc != 1 } {
    puts "Pass vlnv string of the ip as an argument"
    exit
    }
set VLNV [lindex $argv 0]
create_project -in_memory
create_ip -vlnv $VLNV -module_name iphelp
puts [report_property -all [get_ips]]
puts "Supported targets:"
foreach tgt [list_targets [get_files]] {
    puts -nonewline "    "
    puts $tgt
    }
