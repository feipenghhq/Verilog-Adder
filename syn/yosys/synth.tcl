# hide the original read command in tcl, because yosys also have a read command
interp hide {} read
yosys -import

set repo_root ../..
set liberty_file $repo_root/syn/yosys/lib/osu_freepdk_1.0/gscl45nm.lib
set YOSYS_DEFINE $::env(YOSYS_DEFINE)

# read define
read -define SYNTHESIS
foreach define $YOSYS_DEFINE {
    puts "INFO: Adding user define: $define"
    read -define $define
}


# read design
read_verilog -sv $repo_root/src/rtl/Full_Adder.sv
read_verilog -sv $repo_root/src/rtl/Ripple_Carry_Adder.sv
read_verilog -sv $repo_root/src/rtl/Carry_Select_Adder.sv
read_verilog -sv $repo_root/src/rtl/Carry_Lookahead_Adder.sv
read_verilog -sv $repo_root/syn/rtl/top.sv
hierarchy -top top

# the high-level stuff
procs; fsm; opt; memory; opt

# mapping to internal cell library
techmap; opt

# mapping flip-flops to vsclib013.lib
dfflibmap -liberty $liberty_file

# mapping logic to vsclib013.lib
abc -liberty $liberty_file -constr timing.sdc

# cleanup
clean

# flatten the design hierarchy before writing verilog to avoid
# the weird intermediate module name
flatten

# write the verilog file
write_verilog -noattr top.syn.v

stat -liberty $liberty_file