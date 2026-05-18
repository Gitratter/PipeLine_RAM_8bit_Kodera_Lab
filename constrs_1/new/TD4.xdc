##clk
set_property IOSTANDARD LVCMOS33 [get_ports clk]
set_property PACKAGE_PIN W5 [get_ports clk]
create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports clk]

##reset
set_property IOSTANDARD LVCMOS33 [get_ports reset]
set_property PACKAGE_PIN U18 [get_ports reset]

##IN
set_property PACKAGE_PIN V17 [get_ports {in[0]}]
set_property PACKAGE_PIN V16 [get_ports {in[1]}]
set_property PACKAGE_PIN W16 [get_ports {in[2]}]
set_property PACKAGE_PIN W17 [get_ports {in[3]}]
set_property PACKAGE_PIN W15 [get_ports {in[4]}]
set_property PACKAGE_PIN V15 [get_ports {in[5]}]
set_property PACKAGE_PIN W14 [get_ports {in[6]}]
set_property PACKAGE_PIN W13 [get_ports {in[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports in[*]]

##OUT
set_property PACKAGE_PIN U16 [get_ports {out[0]}]
set_property PACKAGE_PIN E19 [get_ports {out[1]}]
set_property PACKAGE_PIN U19 [get_ports {out[2]}]
set_property PACKAGE_PIN V19 [get_ports {out[3]}]
set_property PACKAGE_PIN W18 [get_ports {out[4]}]
set_property PACKAGE_PIN U15 [get_ports {out[5]}]
set_property PACKAGE_PIN U14 [get_ports {out[6]}]
set_property PACKAGE_PIN V14 [get_ports {out[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports out[*]]

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
