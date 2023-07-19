# Verilog Adder

[TOC]

## Introduction

This repository contains various adder design using Verilog. 

| Name                  | RTL file                         |
| --------------------- | -------------------------------- |
| 1 bit Full Adder      | src/rtl/Full_Adder.sv            |
| Ripple Carry Adder    | src/rtl/Ripple_Carry_Adder.sv    |
| Carry Select Adder    | src/rtl/Carry_Select_Adder.sv    |
| Carry Lookahead Adder | src/rtl/Carry_Lookahead_Adder.sv |



## Prerequisite

This repo used the following tools for various design task

- [iverilog](https://github.com/steveicarus/iverilog): iverilog is used for simulation
- [AMD Vivado](https://www.xilinx.com/products/design-tools/vivado.html): Vivado is used for FPGA synthesis
- [Yosys](https://github.com/YosysHQ/yosys): Yosys is used for ASIC synthesis
- [OpenSTA](https://github.com/The-OpenROAD-Project/OpenSTA): OpenSTA is used for static timing analysis (STA) after Yosys synthesis



## Simulation

There are some simple simulation to test the function of the adder

```shell
cd verif/tests
# Run simulation for all the adders
make
# Run simluation for a specific adder
# For example: make Ripple_Carry_Adder
make <adder_name>
```

