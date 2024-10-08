set SRCS        $env(SRCS)
set TOP         $env(TOP)
set PARTNAME    $env(PARTNAME)
set DCP         $TOP
set USE2008     $env(USE2008)

append DCP .synth.dcp
set PARTNAME $env(PARTNAME)
create_project -in_memory -part $PARTNAME

# Currently only vhdl libraries are supported, no technical reason for that
foreach FILE $env(LIBSRCS) {
    set EXT [ file extension $FILE ]
    if { $EXT != ".vhdl" } {
        puts "Only .vhdl extension is supported for libraries"
        exit 1
    }
    set LIBNAME [file root [file tail $FILE]]
    puts -nonewline "Processing library "
    puts -nonewline $FILE
    puts $LIBNAME
    read_vhdl -library $LIBNAME $FILE
}

foreach FILE $env(SRCS) {
    set EXT [ file extension $FILE ]
    if { $EXT == ".vhdl" } {
        if { $USE2008 == "yes" } {
            read_vhdl -vhdl2008 $FILE
        } else {
            read_vhdl $FILE
        }
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
# In absence of opt_design place stage advises to run it if undriven nets were
# found. Not enabled by default
# opt_design
write_checkpoint -force $DCP
