/* ---------------------------------------------------------------
 * Copyright (c) 2022. Heqing Huang (feipenghhq@gmail.com)
 *
 * Author: Heqing Huang
 * Date Created: 07/11/2023
 * ---------------------------------------------------------------
 * Testbench for Ripple_Carry_Adder
 * ---------------------------------------------------------------
 */

module test_Ripple_Carry_Adder();

    parameter WIDTH = 8;

    logic [WIDTH-1:0]    a;
    logic [WIDTH-1:0]    b;
    logic                cin;
    logic [WIDTH-1:0]    s;
    logic                cout;

    tb_env #(.WIDTH(WIDTH), .DEBUG(1))
    u_tb_env(.*);

    Ripple_Carry_Adder #(.WIDTH(WIDTH))
    u_Ripple_Carry_Adder(.*);

    initial begin
        $display("^^^ TESTING: Ripple_Carry_Adder ^^^");
    end

    //initial begin
    //    $dumpfile("dump.vcd");
    //    $dumpvars(0,test_multiplier_unsigned_FA);
    //end

endmodule