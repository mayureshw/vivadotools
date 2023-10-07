set SRCS        $env(SRCS)
set TOP         $env(TOP)
set PARTNAME    $env(PARTNAME)
set DCP         $TOP

append DCP .synth.dcp

foreach FILE $env(SRCS) {
    set EXT [ file extension $FILE ]
    if { $EXT == ".vhdl" } {
        read_vhdl -vhdl2008 $FILE
    } elseif { $EXT == ".xci" } {
        read_ip $FILE
    } else {
        add_files $FILE
    }
}

synth_ip [get_ips]
set_property top $TOP [get_filesets sources_1]
if { $PARTNAME != "" } {
    synth_design -rtl -part $PARTNAME
    synth_design -part $PARTNAME
} else {
    synth_design -rtl
    synth_design
    }
write_checkpoint -force $DCP
