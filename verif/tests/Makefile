
VERILOG_DIR = ../../src/rtl
TESTBENCH_DIR = ../testbench

TARGET = Ripple_Carry_Adder Carry_Select_Adder Carry_Lookahead_Adder

VERILOG_SRC += $(VERILOG_DIR)/Full_Adder.sv
VERILOG_SRC += $(VERILOG_DIR)/Ripple_Carry_Adder.sv
VERILOG_SRC += $(VERILOG_DIR)/Carry_Select_Adder.sv
VERILOG_SRC += $(VERILOG_DIR)/Carry_Lookahead_Adder.sv

all: $(TARGET)

.PHONY: $(TARGET)

$(TARGET): % :$(VERILOG_SRC) $(TESTBENCH_DIR)/tb_env.sv test_%.sv
	iverilog -g2012 $^ -o $@
	./$@

clean:
	rm -rf $(TARGET) *.vcd
