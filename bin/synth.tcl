set SRCS $env(SRCS)
set TOP  $env(TOP)
set DCP  $TOP
append DCP .synth.dcp

add_files $SRCS
set_property top $TOP [get_filesets sources_1]
synth_design -rtl
synth_design
write_checkpoint -force $DCP
