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



## Synthesis

The design is synthesis using Vivado and Yosys to compare area/timing between different designs and parameters.

For vivado, the target device is Arty A7 series. For Yosys, the gscl45 nm library is used.

A top level module is written as synthesis top. The input and output of the adder are flops in the top level module to measure the internal timing for FPGA.

The clock period used in both the Vivado and Yosys is 10ns (100MHz)

```shell
# Vivado
cd syn/vivado
make NAME=<adder_name> WIDTH=<adder_width>
# Vivado Example:
make ADDER_NAME=Ripple_Carry_Adder WIDTH=16
```

### Synthesis Result

| Design                | Width | LUT (Vivado) | Timing (Vivado) | Area (Yosys) | Timing (Yosys) |
| --------------------- | ----- | ------------ | --------------- | ------------ | -------------- |
| Ripple Carry Adder    | 16    | 16           | 4.120           | 654.204200   | 8.54           |
| Ripple Carry Adder    | 32    | 32           | -0.560          | 1292.452200  | 7.22           |
| Ripple Carry Adder    | 64    | 64           | -9.920          | 2568.948200  | 4.59           |
| Carry Select Adder    | 16    | 25           | 5.675           | 927.336800   | 9.22           |
| Carry Select Adder    | 32    | 55           | 4.445           | 1918.498400  | 8.76           |
| Carry Select Adder    | 64    | 115          | 2.045           | 3900.821600  | 7.83           |
| Carry Lookahead Adder | 16    | 26           | 5.859           |              |                |
| Carry Lookahead Adder | 64    | 169          | 4.134           |              |                |

