set repo_root ../..
set liberty_file $repo_root/syn/yosys/lib/osu_freepdk_1.0/gscl45nm.lib

read_liberty $liberty_file
read_verilog top.syn.v
link_design top
read_sdc timing.sdc
report_checks -path_delay max
exit