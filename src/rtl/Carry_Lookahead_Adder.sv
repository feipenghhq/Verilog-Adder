/* ---------------------------------------------------------------
 * Copyright (c) 2022. Heqing Huang (feipenghhq@gmail.com)
 *
 * Author: Heqing Huang
 * Date Created: 07/16/2023
 * ---------------------------------------------------------------
 * Carry Lookahead Adder
 * ---------------------------------------------------------------
 */

/*
Note about Carry Lookahead Adder

pi = ai ^ bi;
gi = ai & bi;

For a 4 bit CLA:

P4 = p3 & p2 & p1 & p0
G4 = g3 + p3 & g2 + p3 & p2 & g1 + p3 & p2 & p1 & g0

cout = G4 | (P4 & cin)
Si = pi ^ ci

We can cascade CLA together to form a bigger CLA
P & G propagate foward from lower level to upper level
cout propagate backward from upper level to lower level

*/

module Carry_Lookahead_Adder #(
    // Note about WIDTH and SIZE parameters:
    // Must make sure the follow relationship: WIDTH = SIZE ** n (n is integer and n > 0)
    // For example, for a 4 bit CLA logic unit (SIZE = 4), CLA adder width (WIDTH) can be 4, 16, 64
    // For other width, we can't use CLA logic recursively, user can create a new adder using CLA.
    // For example, for a 32 bit adder, we can cascade 2 16 bit CLA together.
    parameter WIDTH = 16,   // adder width
    parameter SIZE  = 4     // carry lookahead unit size.
) (
   input  [WIDTH-1:0]   a,
   input  [WIDTH-1:0]   b,
   input                cin,
   output [WIDTH-1:0]   s,
   output               cout
);

    // Depth (Level) of CLA logic
    localparam DEPTH = calc_depth();

    logic          [WIDTH-1:0] c_int;
    logic [DEPTH:0][WIDTH-1:0] P_int;
    logic [DEPTH:0][WIDTH-1:0] G_int;

    `ifndef SYNTHESIS
    initial begin
        $display("INFO: DEPTH = %d", DEPTH);
    end
    `endif

    genvar level;
    genvar cla_idx;
    genvar carry_idx;
    genvar i;

    generate

        // Generate P and G from input (Level 0)
        assign P_int[0] = a ^ b;
        assign G_int[0] = a & b;

        // The 0th bit of the carry for each level is cin
        assign c_int[0] = cin;

        // CLA_logic from level DEPTH to level 1
        for (level = DEPTH; level > 0; level--) begin: gen_cla_level

            // Number of CLA logic unit in each level
            localparam CLA_COUNT = SIZE ** (DEPTH-level);

            // This is Carry interval to be propagate back to previous level
            localparam CARRY_INTERVAL = SIZE ** (level-1);

            // CLA_logic in each level
            for (cla_idx = 0; cla_idx < CLA_COUNT; cla_idx++) begin: gen_cla

                logic [SIZE-1:0] c_int_tmp;

                CLA_logic #(.WIDTH(SIZE))
                u_cla_logic (
                    .p_i(P_int[level-1][SIZE*(cla_idx+1)-1:cla_idx*SIZE]),
                    .g_i(G_int[level-1][SIZE*(cla_idx+1)-1:cla_idx*SIZE]),
                    .c_i(c_int[CARRY_INTERVAL*SIZE*cla_idx]),
                    .p_o(P_int[level][cla_idx]),
                    .g_o(G_int[level][cla_idx]),
                    .c_o(c_int_tmp)
                );

                // Propagate carry to its corresponding position in c_int
                for (carry_idx = 0; carry_idx < SIZE - 1; carry_idx++) begin
                    localparam CARRY_LOC = CARRY_INTERVAL * (carry_idx+1) + cla_idx * (SIZE ** level);
                    assign c_int[CARRY_LOC] = c_int_tmp[carry_idx];
                end
            end
        end

        // Generate Sum
        assign s = P_int[0] ^ c_int;

        // Generate Cout
        assign cout = G_int[DEPTH][0] | P_int[DEPTH][0] & cin;

    endgenerate

    function integer calc_depth;
        integer i = 0;
        calc_depth = -1;
        for (i = 1; i < WIDTH; i++) begin
            if ((SIZE ** i) == WIDTH) begin
                calc_depth = i;
            end
        end
    endfunction

endmodule

// CLA_logic: generation P/G and Cout
module CLA_logic #(
    parameter WIDTH = 4
) (
    input [WIDTH-1:0]   p_i,
    input [WIDTH-1:0]   g_i,
    input               c_i,
    output              p_o,
    output              g_o,
    output [WIDTH-1:0]  c_o
);

    logic [WIDTH-1:0]   P_int;
    logic [WIDTH-1:0]   G_int;

    genvar p_idx;
    genvar g_idx_i;
    genvar g_idx_j;
    genvar carry_idx;
    generate

        // P generation
        for (p_idx = 0; p_idx < WIDTH; p_idx++) begin: gen_P
            assign P_int[p_idx] = &p_i[p_idx:0];
        end
        assign p_o = P_int[WIDTH-1];

        // G generation
        // Example: G4 = g3 + p3 & g2 + p3 & p2 & g1 + p3 & p2 & p1 & g0
        // Note our g_idx_i index starts from 0, so G_int[0] => G1, ..., G_int[3] => G4
        for (g_idx_i = 0; g_idx_i < WIDTH; g_idx_i++) begin: gen_G
            logic [WIDTH-1:0] G_int_prd;
            assign G_int_prd[g_idx_i] = g_i[g_idx_i];
            // Generate each item of Gi (for each item in the above example)
            for (g_idx_j = 0; g_idx_j < g_idx_i; g_idx_j++) begin: gen_G_prd
                assign G_int_prd[g_idx_j] = (&(p_i[g_idx_i:g_idx_j+1])) & g_i[g_idx_j];
            end
            // OR all the items together (for the + operation in the above example)
            assign G_int[g_idx_i] = |G_int_prd[g_idx_i:0];
        end

        assign g_o = G_int[WIDTH-1];

        // C generation
        for (carry_idx = 0; carry_idx < WIDTH; carry_idx++) begin: gen_C
            assign c_o[carry_idx] = G_int[carry_idx] | P_int[carry_idx] & c_i;
        end

    endgenerate

endmodule