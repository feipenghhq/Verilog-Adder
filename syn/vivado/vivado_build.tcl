# ---------------------------------------------------------------
# Copyright (c) 2022. Heqing Huang (feipenghhq@gmail.com)
# Author: Heqing Huang
# Date Created: 07/23/2022
# ---------------------------------------------------------------
# Tcl Script for Vivado
# ---------------------------------------------------------------

set_param general.maxThreads 16

# ----------------------------------------
# Step 1: Create project Design Setup
# ----------------------------------------

set VIVADO_DEVICE   $::env(VIVADO_DEVICE)
set VIVADO_PRJ      $::env(VIVADO_PRJ)
set VIVADO_TOP      $::env(VIVADO_TOP)
set VIVADO_VERILOG  $::env(VIVADO_VERILOG)
set VIVADO_SEARCH   $::env(VIVADO_SEARCH)
set VIVADO_XDC      $::env(VIVADO_XDC)
set VIVADO_DEFINE   $::env(VIVADO_DEFINE)

create_project $VIVADO_PRJ -dir $VIVADO_PRJ -part $VIVADO_DEVICE -force

# ----------------------------------------
# Step 2: Read in source files
# ----------------------------------------

# read in rtl search path
set_property include_dirs $VIVADO_SEARCH [current_fileset]

# read in defines
set defines [list SYNTHESIS VIVADO]
foreach define $VIVADO_DEFINE {
    puts "INFO: Adding user define: $define"
    lappend defines $define
}
set_property verilog_define $defines [current_fileset]

# read in verilog source files
read_verilog    $VIVADO_VERILOG

# read in xdc files
read_xdc        $VIVADO_XDC

# ----------------------------------------
# Step 3: synthesis
# ----------------------------------------
synth_design -part $VIVADO_DEVICE -top $VIVADO_TOP
write_checkpoint -force syn/syn_checkpoint

report_timing_summary -file syn/syn_timing.rpt
report_utilization -file syn/syn_utilization_all.rpt
report_utilization -hierarchical -file syn/syn_utilization_hier.rpt

# ----------------------------------------
# Step 3: Finish
# ----------------------------------------

close_design

exit