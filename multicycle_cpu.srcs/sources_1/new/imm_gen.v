`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/31/2026 10:07:47 PM
// Design Name: 
// Module Name: imm_gen
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module imm_gen(
    input[31:0] full_instr,
    output reg [31:0] imm_out
    );
    
    
    always @(*) begin
        case(full_instr[6:0])
            // for I-type instructions
            7'b0010011: imm_out = {{20{full_instr[31]}}, full_instr[31:20]};
            7'b0000011: imm_out = {{20{full_instr[31]}}, full_instr[31:20]};
            
            // for S-type instructions
            7'b0100011: imm_out = {{20{full_instr[31]}}, full_instr[31:25], full_instr[11:7]};
            
            // for B-type instructions
            7'b1100011: imm_out = {{19{full_instr[31]}}, full_instr[31], full_instr[7], full_instr[30:25], full_instr[11:8], 1'b0};

            /// for U-type instruction
            7'b0110111: imm_out = {full_instr[31:12],  12'b0};
            
            // for J-type instructions
            7'b1101111: imm_out = {{11{full_instr[31]}}, full_instr[31], full_instr[19:12], full_instr[20], full_instr[30:21], 1'b0};
            default: imm_out = 32'h00000000;
        endcase
    end
    
endmodule
