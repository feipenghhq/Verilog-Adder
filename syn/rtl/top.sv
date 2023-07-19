/* ---------------------------------------------------------------
 * Copyright (c) 2022. Heqing Huang (feipenghhq@gmail.com)
 *
 * Author: Heqing Huang
 * Date Created: 07/18/2023
 * ---------------------------------------------------------------
 * Top Level for Synthesis
 * ---------------------------------------------------------------
 */

 module top #(
    parameter WIDTH = `WIDTH
) (
    input                clk,
    input  [WIDTH-1:0]   a,
    input  [WIDTH-1:0]   b,
    input                cin,
    output [WIDTH-1:0]   s,
    output               cout
);

    // Flop all the input/output
    logic [WIDTH-1:0]    a_ff;
    logic [WIDTH-1:0]    b_ff;
    logic                cin_ff;
    logic [WIDTH-1:0]    s_ff;
    logic                cout_ff;

    logic [WIDTH-1:0]    s_comb;
    logic                cout_comb;

    `ADDER_NAME #(.WIDTH(WIDTH))
    u_adder(
        .a      (a_ff),
        .b      (b_ff),
        .cin    (cin_ff),
        .s      (s_comb),
        .cout   (cout_comb)
    );

    always @(posedge clk) begin
        a_ff <= a;
        b_ff <= b;
        cin_ff <= cin;
        s_ff <= s_comb;
        cout_ff <= cout_comb;
    end

    assign s = s_ff;
    assign cout = cout_ff;

endmodule