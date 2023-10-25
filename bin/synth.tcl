set SRCS        $env(SRCS)
set TOP         $env(TOP)
set PARTNAME    $env(PARTNAME)
set DCP         $TOP

append DCP .synth.dcp
set PARTNAME $env(PARTNAME)
create_project -in_memory -part $PARTNAME

foreach FILE $env(SRCS) {
    set EXT [ file extension $FILE ]
    if { $EXT == ".vhdl" } {
        read_vhdl -vhdl2008 $FILE
    } elseif { $EXT == ".dcp" } {
        read_checkpoint $FILE
    } else {
        add_files $FILE
    }
}

set_property top $TOP [get_filesets sources_1]
# -rtl option elaborates and opens an rtl design
synth_design -rtl
synth_design
# In absence of opt_design place stage anyway advises to run it
# if undriven nets were found
opt_design
write_checkpoint -force $DCP
