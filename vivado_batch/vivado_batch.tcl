# Created : 9:31:38, Tue Jun 21, 2016 : Sanjay Rai

source ../device_type.tcl

set TOP_module FPGA_skeleton
set ROLE_CLK_PERIOD 4.000

proc build_design {ARGV_0 ARGV_1} { 
upvar 1 $ARGV_0 TOP_module
upvar 1 $ARGV_1 ROLE_CLK_PERIOD
    create_project -in_memory -part [DEVICE_TYPE] 


    read_verilog -sv "
    ../src/FPGA_skeleton_if.sv
    ../src/$TOP_module.sv
    "

    read_xdc "
    ../src/xdc/$TOP_module.xdc
    "

    synth_design -keep_equivalent_registers -shreg_min_size 8 -include_dirs ../src -top $TOP_module -part [DEVICE_TYPE] 


    if (0) {
    opt_design -verbose -directive Explore

    write_checkpoint -force ./$TOP_module.post_synth_opt.dcp
    place_design -verbose -directive Explore
    write_checkpoint -force ./$TOP_module.post_place.dcp
    phys_opt_design  -verbose -directive Explore
    write_checkpoint -force ./$TOP_module.post_place_phys_opt.dcp
    route_design  -verbose -directive Explore
    write_checkpoint -force ./$TOP_module.post_route.dcp
    phys_opt_design  -verbose -directive Explore
    write_checkpoint -force ./$TOP_module.post_route_phys_opt.dcp
    write_debug_probes ./$TOP_module.ltx
    report_timing_summary -file $TOP_module.timing_summary.rpt
    report_drc -file $TOP_module.drc.rpt

    set_property BITSTREAM.CONFIG.CONFIGRATE 85.0 [current_design]
    set_property BITSTREAM.CONFIG.SPI_32BIT_ADDR YES [current_design]
    set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]
    set_property BITSTREAM.CONFIG.SPI_FALL_EDGE YES [current_design]
    set_property BITSTREAM.CONFIG.SPI_BUSWIDTH 4 [current_design]
    set_property BITSTREAM.CONFIG.EXTMASTERCCLK_EN Disable [current_design]
    set_property CONFIG_MODE SPIx4 [current_design]
    set_property CONFIG_VOLTAGE 1.8 [current_design]
    set_property CFGBVS GND [current_design]
    write_bitstream -bin_file $TOP_module.bit      
    write_cfgmem  -format mcs -size 512 -interface SPIx4 -loadbit "up 0x00000000 $TOP_module.bit " -file "$TOP_module.mcs"
    }

}
build_design TOP_module ROLE_CLK_PERIOD 
