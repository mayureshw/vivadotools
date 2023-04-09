set SRCS        $env(SRCS)
set TOP         $env(TOP)
set PARTNAME    $env(PARTNAME)
set DCP         $TOP

append DCP .synth.dcp

add_files $SRCS
set_property top $TOP [get_filesets sources_1]
if { $PARTNAME != "" } {
    synth_design -rtl -part $PARTNAME
    synth_design -part $PARTNAME
} else {
    synth_design -rtl
    synth_design
    }
write_checkpoint -force $DCP
