set TOP  $env(TOP)
set LASTDCP  $TOP
set DCP  $TOP
append LASTDCP .route.dcp
append DCP .edif

create_project -in_memory
open_checkpoint $LASTDCP
#write_edif -force $DCP
#write_vhdl -force see.vhdl
#foreach o [ get_nets ] {
#    foreach do [ get_net_delays -of_objects $o ] {
#        report_property -all $do
#    }
#}

set ahir [ get_cells  -filter { REF_NAME == ahirlb } ]

foreach n [ get_nets -segments -of_objects $ahir ] {
    puts $n
}


#foreach mc [ get_cells -hier -filter { REF_NAME =~ LUT* } ] {
#    foreach sm [ get_speed_models -of_objects $mc ] {
#        report_property -all $sm
#    }
#}

#foreach c [ get_cells -hier -filter { REF_NAME =~ LUT* } ] {
#    foreach o [ get_pins -of_objects $c -filter { DIRECTION == out } ] {
#        foreach n [ get_nets -of_objects $o ] {
#            set loopbacks {}
#            set forwards {}
#            foreach i [ get_pins -of_objects $n -filter { DIRECTION == in } ] {
#                set ci [ get_cells -of_objects $i ]
#                if { $c == $ci } {
#                    lappend loopbacks $i
#                } else {
#                    lappend forwards $i
#                }
#            }
#            if { [ llength $loopbacks ] > 0 && [ llength $forwards ] > 0 } {
#                puts "for $o"
#                #foreach delay [ get_net_delays -of_objects $n ] {
#                #    report_property -all $delay
#                #}
#                foreach p [ get_pins -of_objects $c -filter { DIRECTION == in } ] {
#                    puts [ get_timing_paths -from $p -to $o ]
#                }
#            }
#        }
#    }
#}
                #puts "feedback timings"
                #foreach i $loopbacks {
                #    report_timing -from $o -to $i
                #}
                #puts "forward timings"
                #foreach i $forwards {
                #    report_timing -from $o -to $i
                #}

#foreach c [ get_cells -hier -filter { REF_NAME =~ LUT* } ] {
#    puts "[ get_property NAME $c ] [ get_property PARENT $c ]"
#}

#foreach y [ get_pins -hier -filter { REF_PIN_NAME == y && REF_NAME =~ MullerC* && DIRECTION == OUT } ] {
#    puts ""
#    puts " OUT [ get_property NAME $y ]"
#    puts "====================="
#    foreach n [ get_nets -of_objects $y ] {
#        foreach p [ get_pins -of_objects $n -filter { DIRECTION == IN } ] {
#            puts [ get_property NAME $p ]
#        }
#    }
#}

#foreach c [ get_cells -hier -filter { REF_NAME =~ MullerC* } ] {
#    puts ""
#    puts [ get_property NAME $c ]
#    puts "=================================="
#    foreach n [ get_nets -of_object $c ] {
#        foreach  opin [ get_pins -of_objects $n -filter { DIRECTION == OUT } ] {
#            foreach ipin [ get_pins -of_objects $n -filter { DIRECTION == IN } ] {
#                puts "[ get_property NAME $opin ] -> [ get_property NAME $ipin ]"
#            }
#        }
#    }
#}
