

# verilog define
ADDER_NAME ?= Ripple_Carry_Adder
WIDTH ?= 32

DEFINE += ADDER_NAME=$(ADDER_NAME)
DEFINE += WIDTH=$(WIDTH)

export YOSYS_DEFINE	= $(DEFINE)

syn: top.syn.v

sta: top.syn.v
	sta opensta.tcl | tee sta.log

top.syn.v:
	yosys -c synth.tcl | tee syn.log

clean:
	rm -rf *.log *.v