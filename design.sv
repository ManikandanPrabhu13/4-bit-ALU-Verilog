
// 4-bit ALU — RTL Module
// Operations: ADD, SUB, AND, OR, NOT (on A)
// Author: Manikandan Prabhu B

module alu_4bit (
    input  [3:0] A,      // 4-bit input A
    input  [3:0] B,      // 4-bit input B
    input  [2:0] opcode, // Operation selector
    output reg [4:0] result, // 5-bit result (handles carry)
    output reg zero_flag     // 1 if result is zero
);

    // Opcode definitions
    // 000 = ADD
    // 001 = SUB
    // 010 = AND
    // 011 = OR
    // 100 = NOT A

    always @(*) begin
        case (opcode)
            3'b000: result = A + B;          // ADD
            3'b001: result = A - B;          // SUB
            3'b010: result = {1'b0, A & B};  // AND
            3'b011: result = {1'b0, A | B};  // OR
            3'b100: result = {1'b0, ~A};     // NOT A
            default: result = 5'b00000;
        endcase

        // Zero flag
        zero_flag = (result == 5'b00000) ? 1'b1 : 1'b0;
    end

endmodule  
