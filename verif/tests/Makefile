
VERILOG_SRC_DIR = ../../src/rtl
TESTBENCH_DIR = ../testbench

TARGET = Ripple_Carry_Adder

all: $(TARGET)

.PHONY: all

$(TARGET): % :$(VERILOG_SRC_DIR)/%.sv $(VERILOG_SRC_DIR)/Full_Adder.sv $(TESTBENCH_DIR)/tb_env.sv test_%.sv
	iverilog -g2012 $^ -o $@
	./$@

clean:
	rm -rf $(TARGET) *.vcd
