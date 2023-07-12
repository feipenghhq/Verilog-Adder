/* ---------------------------------------------------------------
 * Copyright (c) 2022. Heqing Huang (feipenghhq@gmail.com)
 *
 * Author: Heqing Huang
 * Date Created: 07/11/2023
 * ---------------------------------------------------------------
 * Testbench environment for adder
 * ---------------------------------------------------------------
 */

 module tb_env #(
    parameter WIDTH = 32
 )(
    output logic [WIDTH-1:0]    a,
    output logic [WIDTH-1:0]    b,
    output logic                cin,
    input  logic [WIDTH-1:0]    s,
    input  logic                cout
 );

    parameter DEBUG = 0;
    parameter ITER = 10;

    logic [WIDTH-1:0] expected_s;
    logic             expected_cout;

    assign {expected_cout, expected_s} = a + b + cin;

    // drive stimulus
    initial begin
        #10;
        $display("---------- Testing Multiplication ----------");
        $display("NOTE: If no ERROR being printed out, then the test pass.");
        $display("--------------------------------------------");
        repeat (ITER) begin
            drive_stimulus();
            check_result();
        end
        #10;
    end

    task automatic drive_stimulus;
        a = $random;
        b = $random;
        cin = $random;
        #10;
    endtask

    task automatic check_result;
        if (expected_cout !== cout) begin
            $error("Error: Wrong cout result from DUT. %d + %d. Expected: %d, Actual: %d",
                    a, b, expected_cout, cout);
        end
        else if (expected_s !== s) begin
            $error("Error: Wrong s result from DUT. %d + %d. Expected: %d, Actual: %d",
                    a, b, expected_s, s);
        end
        else begin
            if (DEBUG) $display("Check passed. %d + %d = %d", a, b, expected_s);
        end

    endtask

 endmodule