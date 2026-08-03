`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/01/2026 11:39:12 PM
// Design Name: 
// Module Name: alu_control
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Control logic for ALU
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module alu_control(
    input [31:0] full_instr,
    input [1:0] ALUOp,
    output reg[3:0] alu_control_out
    );

    // wire func3 full_instr[14:12];
    // wire func7 full_instr[31:25]; 

    always @(*) begin
        case (ALUOp)
            2'b00: alu_control_out = 4'b0010;
            2'b01: alu_control_out = 4'b0110;
            2'b10: begin
                // cases for type of instruction
                case (full_instr[6:0])
                    // R-type instruction
                    7'b0110011: case ({full_instr[31:25], full_instr[14:12]})
                                    10'b0000000_000: alu_control_out = 4'b0010;     // add
                                    10'b0100000_000: alu_control_out = 4'b0110;     // sub
                                    10'b0000000_100: alu_control_out = 4'b0011;     // xor
                                    10'b0000000_110: alu_control_out = 4'b0001;     // or
                                    10'b0000000_111: alu_control_out = 4'b0000;     // and
                                    10'b0000000_001: alu_control_out = 4'b0111;     // shift left logical
                                    10'b0000000_101: alu_control_out = 4'b0101;     // shift right logical
                                    10'b0100000_101: alu_control_out = 4'b1011;     // shift right arith
                                    10'b0000000_010: alu_control_out = 4'b1111;     // set less then
                                    10'b0000000_011: alu_control_out = 4'b1000;     // set less then (U)
                            endcase

                    // I-type instruction
                    7'b0010011: case ({full_instr[31:25], full_instr[14:12]})
                                10'b0000000_000: alu_control_out = 4'b0010;     // addi
                                10'b0000000_100: alu_control_out = 4'b0011;     // xori
                                10'b0000000_110: alu_control_out = 4'b0001;     // ori
                                10'b0000000_111: alu_control_out = 4'b0000;     // andi
                                10'b0000000_001: alu_control_out = 4'b0111;     // slli
                                10'b0000000_101: alu_control_out = 4'b0101;     // srli
                                10'b0100000_101: alu_control_out = 4'b1011;     // srai
                                10'b0000000_010: alu_control_out = 4'b1111;     // slti
                                10'b0000000_011: alu_control_out = 4'b1000;     // sltiu
                            endcase

                    // S-type instructions are always add so no need for case

                    // B-type of instructionsv
                    7'b1100011: case ({full_instr[14:12]})
                                3'b000: alu_control_out = 4'b0110;
                                3'b001: alu_control_out = 4'b1001;       // bne
                                3'b100: alu_control_out = 4'b0100;       // blt
                                3'b101: alu_control_out = 4'b1100;       // bge
                                3'b110: alu_control_out = 4'b1101;       // bltu
                                3'b111: alu_control_out = 4'b1110;       // bgeu
                            endcase

                    // U-type instruction
                    // 7'b0110111: alu_control_out = 4'b1010;

                    // J-type instructions use add
                endcase
            end
            default: alu_control_out = 4'bxxxx;
        endcase
    end
endmodule
