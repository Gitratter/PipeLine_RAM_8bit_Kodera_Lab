##clk
set_property IOSTANDARD LVCMOS33 [get_ports CLK]
set_property PACKAGE_PIN W5 [get_ports CLK]
create_clock -add -name sys_clk_pin -period 10.00 -waveform{05}[get_ports CLK]

##reset
set_property IOSTANDARD LVCMOS33 [get_ports reset]
set_property PACKAGE_PIN U18 [get_ports reset]

##IN
set_property PACKAGE_PIN V17 [get_ports {IN[0]}]
set_property PACKAGE_PIN V16 [get_ports {IN[1]}]
set_property PACKAGE_PIN W16 [get_ports {IN[2]}]
set_property PACKAGE_PIN W17 [get_ports {IN[3]}]
set_property PACKAGE_PIN W15 [get_ports {IN[4]}]
set_property PACKAGE_PIN V15 [get_ports {IN[5]}]
set_property PACKAGE_PIN W14 [get_ports {IN[6]}]
set_property PACKAGE_PIN W13 [get_ports {IN[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports IN[*]]

##OUT
set_property PACKAGE_PIN U16 [get_ports {OUT[0]}]
set_property PACKAGE_PIN E19 [get_ports {OUT[1]}]
set_property PACKAGE_PIN U19 [get_ports {OUT[2]}]
set_property PACKAGE_PIN V19 [get_ports {OUT[3]}]
set_property PACKAGE_PIN W18 [get_ports {OUT[4]}]
set_property PACKAGE_PIN U15 [get_ports {OUT[5]}]
set_property PACKAGE_PIN U14 [get_ports {OUT[6]}]
set_property PACKAGE_PIN V13 [get_ports {OUT[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports OUT[*]]

##clksel
set_property IOSTANDARD LVCMOS33 [get_ports clksel]
set_property PACKAGE_PIN V2 [get_ports clksel]

##clk_ind
set_property PACKAGE_PIN P3 [get_ports {clk_ind[0]}]
set_property PACKAGE_PIN N3 [get_ports {clk_ind[1]}]
set_property PACKAGE_PIN P1 [get_ports {clk_ind[2]}]
set_property PACKAGE_PIN L1 [get_ports {clk_ind[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports clk_ind[*]]

##pipe_ind
set_property PACKAGE_PIN V13 [get_ports pipe_ind0]
set_property PACKAGE_PIN V3 [get_ports pipe_ind1]
set_property PACKAGE_PIN W3 [get_ports pipe_ind2]
set_property PACKAGE_PIN U3 [get_ports pipe_ind3]
set_property IOSTANDARD LVCMOS33 [get_ports pipe_ind0]
set_property IOSTANDARD LVCMOS33 [get_ports pipe_ind1]
set_property IOSTANDARD LVCMOS33 [get_ports pipe_ind2]
set_property IOSTANDARD LVCMOS33 [get_ports pipe_ind3]