/* ---------------------------------------------------------------
 * Copyright (c) 2022. Heqing Huang (feipenghhq@gmail.com)
 *
 * Author: Heqing Huang
 * Date Created: 07/11/2023
 * ---------------------------------------------------------------
 * Full adder cell
 * ---------------------------------------------------------------
 */

module Full_Adder (
    input   a,
    input   b,
    input   cin,
    output  s,
    output  cout
);

    assign s = a ^ b ^ cin;
    assign cout = (a & b) | (a & cin) | (b & cin);

endmodule
