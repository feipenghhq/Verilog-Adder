/* ---------------------------------------------------------------
 * Copyright (c) 2022. Heqing Huang (feipenghhq@gmail.com)
 *
 * Author: Heqing Huang
 * Date Created: 07/11/2023
 * ---------------------------------------------------------------
 * Carry Select Adder
 * ---------------------------------------------------------------
 */

module Carry_Select_Adder #(
    parameter WIDTH = 32,
    parameter BLOCK = 4     // number of FA in a block
) (
   input  [WIDTH-1:0]   a,
   input  [WIDTH-1:0]   b,
   input                cin,
   output [WIDTH-1:0]   s,
   output               cout
);

    localparam FULLY_DIV = (WIDTH % BLOCK == 0);
    localparam NUM_RCA = (WIDTH / BLOCK) + (FULLY_DIV ? 0 : 1);


    logic [NUM_RCA-1:0] carry;

    assign cout = carry[NUM_RCA-1];

    genvar i;
    generate
        // First level
        Ripple_Carry_Adder #(.WIDTH(BLOCK))
        u_RCA_0(.a(a[BLOCK-1:0]), .b(b[BLOCK-1:0]), .cin(cin), .s(s[BLOCK-1:0]), .cout(carry[0]));

        for (i = 1; i < NUM_RCA; i++) begin: gen_RCA
            localparam LAST_LEVEL = (i == NUM_RCA - 1);
            localparam LO = i * BLOCK;
            localparam HI = LAST_LEVEL ? WIDTH - 1: (i + 1) * BLOCK - 1;
            localparam LEVEL_WIDTH = HI - LO + 1;

            logic [BLOCK-1:0] sum_0;
            logic [BLOCK-1:0] sum_1;
            logic             cout_0;
            logic             cout_1;

            Ripple_Carry_Adder #(.WIDTH(LEVEL_WIDTH))
            u_RCA_0(.a(a[HI:LO]), .b(b[HI:LO]), .cin(1'b0), .s(sum_0), .cout(cout_0));

            Ripple_Carry_Adder #(.WIDTH(LEVEL_WIDTH))
            u_RCA_1(.a(a[HI:LO]), .b(b[HI:LO]), .cin(1'b1), .s(sum_1), .cout(cout_1));

            assign carry[i] = carry[i-1] ? cout_1 : cout_0;
            assign s[HI:LO] = carry[i-1] ? sum_1 : sum_0;
        end

    endgenerate

endmodule
