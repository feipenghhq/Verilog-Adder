############################################################
# makefile for vivado flow
############################################################

#########################################################
# Common variable
#########################################################

# Common variable
PWD		  = $(shell pwd)
REPO_ROOT = $(PWD)/../../..
RTL_DIR   = $(REPO_ROOT)/src/rtl/multiplier

#########################################################
# Configure variable
#########################################################

REPO_ROOT	= $(shell git rev-parse --show-toplevel)
SCRIPT_DIR 	= $(REPO_ROOT)/syn/vivado

#########################################################
# Project specific variable
#########################################################

# device
DEVICE ?= xc7a35ticsg324-1L

# project name
PROJECT ?= adder

# top level name
TOP ?= top

# verilog
VERILOG	+= $(REPO_ROOT)/syn/rtl/top.sv
VERILOG	+= $(REPO_ROOT)/src/rtl/Full_Adder.sv
VERILOG	+= $(REPO_ROOT)/src/rtl/Ripple_Carry_Adder.sv
VERILOG	+= $(REPO_ROOT)/src/rtl/Carry_Select_Adder.sv
VERILOG	+= $(REPO_ROOT)/src/rtl/Carry_Lookahead_Adder.sv

# verilog define
ADDER_NAME ?= Ripple_Carry_Adder
WIDTH ?= 32

DEFINE += ADDER_NAME=$(ADDER_NAME)
DEFINE += WIDTH=$(WIDTH)

# xdc
XDC ?= $(PWD)/timing.xdc

# project output directory
OUT_DIR ?= $(PWD)/$(ADDER_NAME)_$(WIDTH)

export VIVADO_DEVICE 	= $(DEVICE)
export VIVADO_PRJ 		= $(PROJECT)
export VIVADO_TOP    	= $(TOP)
export VIVADO_VERILOG  	= $(VERILOG)
export VIVADO_DEFINE	= $(DEFINE)
export VIVADO_SEARCH   	= $(SEARCH)
export VIVADO_XDC		= $(XDC)

############################################################
# Commands
############################################################

syn: clean $(OUT_DIR)
	cd $(OUT_DIR) && vivado -mode tcl -source $(SCRIPT_DIR)/vivado_build.tcl | tee build.log

$(OUT_DIR):
	mkdir -p $(OUT_DIR)

clean:
	rm -rf $(OUT_DIR)
