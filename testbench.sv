// Testbench for 4-bit ALU
// Verifies: ADD, SUB, AND, OR, NOT operations
// Author: Manikandan Prabhu B

`timescale 1ns/1ps

module tb_alu_4bit;

    // Inputs (reg because driven by testbench)
    reg  [3:0] A;
    reg  [3:0] B;
    reg  [2:0] opcode;

    // Outputs (wire because driven by DUT)
    wire [4:0] result;
    wire       zero_flag;

    // Instantiate the ALU (Device Under Test)
    alu_4bit DUT (
        .A(A),
        .B(B),
        .opcode(opcode),
        .result(result),
        .zero_flag(zero_flag)
    );

    // Test sequence
    initial begin
        $dumpfile("alu_waveform.vcd");
        $dumpvars(0, tb_alu_4bit);

        $display("=== 4-bit ALU Functional Verification ===");
        $display("Time | A    | B    | OP  | Result | Zero");

        // --- TEST 1: ADD ---
        A = 4'b0011; B = 4'b0101; opcode = 3'b000; #10;
        $display("%0t  | %b | %b | ADD | %b  | %b",
                  $time, A, B, result, zero_flag);
        // 3 + 5 = 8 → result should be 01000

        // --- TEST 2: SUB ---
        A = 4'b1001; B = 4'b0011; opcode = 3'b001; #10;
        $display("%0t  | %b | %b | SUB | %b  | %b",
                  $time, A, B, result, zero_flag);
        // 9 - 3 = 6 → result should be 00110

        // --- TEST 3: AND ---
        A = 4'b1100; B = 4'b1010; opcode = 3'b010; #10;
        $display("%0t  | %b | %b | AND | %b  | %b",
                  $time, A, B, result, zero_flag);
        // 1100 AND 1010 = 1000

        // --- TEST 4: OR ---
        A = 4'b1100; B = 4'b1010; opcode = 3'b011; #10;
        $display("%0t  | %b | %b | OR  | %b  | %b",
                  $time, A, B, result, zero_flag);
        // 1100 OR 1010 = 1110

        // --- TEST 5: NOT ---
        A = 4'b1010; B = 4'b0000; opcode = 3'b100; #10;
        $display("%0t  | %b | %b | NOT | %b  | %b",
                  $time, A, B, result, zero_flag);
        // NOT 1010 = 0101

        // --- TEST 6: Zero Flag Test ---
        A = 4'b0000; B = 4'b0000; opcode = 3'b000; #10;
        $display("%0t  | %b | %b | ADD | %b  | %b (zero flag!)",
                  $time, A, B, result, zero_flag);
        // 0 + 0 = 0 → zero_flag should be 1

        $display("=== Simulation Complete ===");
        $finish;
    end

endmodule
