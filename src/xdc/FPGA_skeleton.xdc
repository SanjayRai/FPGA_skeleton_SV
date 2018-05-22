create_clock -period 3.333 -name CLK_IN -waveform {0.000 2.500} [get_ports clk_p]

# Physical Constraints
set_property PACKAGE_PIN AY38 [get_ports clk_n];
set_property IOSTANDARD DIFF_SSTL12 [get_ports clk_n];
set_property PACKAGE_PIN AY37 [get_ports clk_p];
set_property IOSTANDARD DIFF_SSTL12 [get_ports clk_p];
