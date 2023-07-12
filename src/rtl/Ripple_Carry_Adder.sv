/* ---------------------------------------------------------------
 * Copyright (c) 2022. Heqing Huang (feipenghhq@gmail.com)
 *
 * Author: Heqing Huang
 * Date Created: 07/11/2023
 * ---------------------------------------------------------------
 * Ripple Carry Adder
 * ---------------------------------------------------------------
 */

module Ripple_Carry_Adder #(
    parameter WIDTH = 32
) (
   input  [WIDTH-1:0]   a,
   input  [WIDTH-1:0]   b,
   input                cin,
   output [WIDTH-1:0]   s,
   output               cout
);

    logic [WIDTH:0] carry;

    assign carry[0] = cin;
    assign cout = carry[WIDTH];

    genvar i;
    generate
        for (i = 0; i < WIDTH; i++) begin: gen_FA
            Full_Adder u_FA(.a(a[i]), .b(b[i]), .cin(carry[i]), .s(s[i]), .cout(carry[i+1]));
        end
    endgenerate

endmodule
