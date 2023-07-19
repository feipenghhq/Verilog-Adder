# Main clock - 100Mhz
# the vsclib013.lib time_unit is 1ns
create_clock -name clk -period 10.000 [get_ports clk]
