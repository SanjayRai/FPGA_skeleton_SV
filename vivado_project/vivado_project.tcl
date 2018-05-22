# Created : 9:31:38, Tue Jun 21, 2016 : Sanjay Rai

source ../device_type.tcl

set TOP_module FPGA_skeleton

proc build_design {ARGV_0 } { 
upvar 1 $ARGV_0 TOP_module
    create_project project_X project_X -part [DEVICE_TYPE] 


    add_files -norecurse "
    ../src/FPGA_skeleton_if.sv
    ../src/$TOP_module.sv
    "

    add_files -fileset constrs_1 -norecurse "
        ../src/xdc/$TOP_module.xdc
    "

    add_files -fileset sim_1 -norecurse "
        ../src/tb_$TOP_module.sv
    "
    
    set_property -name {STEPS.SYNTH_DESIGN.ARGS.MORE OPTIONS} -value {-include_dirs ../src } -objects [get_runs synth_1]

#     set_property BITSTREAM.CONFIG.CONFIGRATE 85.0 [current_design]
#     set_property BITSTREAM.CONFIG.SPI_32BIT_ADDR YES [current_design]
#     set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]
#     set_property BITSTREAM.CONFIG.SPI_FALL_EDGE YES [current_design]
#     set_property BITSTREAM.CONFIG.SPI_BUSWIDTH 4 [current_design]
#     set_property BITSTREAM.CONFIG.EXTMASTERCCLK_EN Disable [current_design]
#     set_property CONFIG_MODE SPIx4 [current_design]
#     set_property CONFIG_VOLTAGE 1.8 [current_design]
#     set_property CFGBVS GND [current_design]
# 
}
build_design TOP_module
