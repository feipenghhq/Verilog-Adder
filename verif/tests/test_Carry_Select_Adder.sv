/* ---------------------------------------------------------------
 * Copyright (c) 2022. Heqing Huang (feipenghhq@gmail.com)
 *
 * Author: Heqing Huang
 * Date Created: 07/11/2023
 * ---------------------------------------------------------------
 * Testbench for Carry_Select_Adder
 * ---------------------------------------------------------------
 */

module test_Carry_Select_Adder();

    parameter WIDTH = 8;
    parameter SIZE = 3;

    logic [WIDTH-1:0]    a;
    logic [WIDTH-1:0]    b;
    logic                cin;
    logic [WIDTH-1:0]    s;
    logic                cout;

    tb_env #(.WIDTH(WIDTH), .DEBUG(1))
    u_tb_env(.*);

    Carry_Select_Adder #(.WIDTH(WIDTH), .SIZE(SIZE))
    u_Carry_Select_Adder(.*);

    initial begin
        $display("^^^ TESTING: Carry_Select_Adder ^^^");
    end

    //initial begin
    //    $dumpfile("dump.vcd");
    //    $dumpvars(0,test_multiplier_unsigned_FA);
    //end

endmodule