/* ---------------------------------------------------------------
 * Copyright (c) 2022. Heqing Huang (feipenghhq@gmail.com)
 *
 * Author: Heqing Huang
 * Date Created: 07/17/2023
 * ---------------------------------------------------------------
 * Testbench for Carry_Lookahead_Adder
 * ---------------------------------------------------------------
 */

module test_Carry_Lookahead_Adder();

    parameter WIDTH = 16;
    parameter SIZE = 4;

    logic [WIDTH-1:0]    a;
    logic [WIDTH-1:0]    b;
    logic                cin;
    logic [WIDTH-1:0]    s;
    logic                cout;

    tb_env #(.WIDTH(WIDTH), .DEBUG(1))
    u_tb_env(.*);

    Carry_Lookahead_Adder #(.WIDTH(WIDTH), .SIZE(SIZE))
    u_Carry_Lookahead_Adder(.*);

    initial begin
        $display("^^^ TESTING: Carry_Lookahead_Adder ^^^");
    end

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0,test_Carry_Lookahead_Adder);
    end

endmodule