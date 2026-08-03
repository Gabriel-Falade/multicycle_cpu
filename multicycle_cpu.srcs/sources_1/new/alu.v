timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/1/2026 02:33:47 PM
// Design Name: 
// Module Name: alu
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

module alu (
    input [31:0]srcA,     // can either be from pc or register
    input [31:0]srcB,     //
    input [3:0]alu_op,
    output reg zero,
    output reg [31:0] alu_out
);

    always @(*) begin
        case(alu_op)
            4'b0000: alu_out = srcA & srcB;     // bit-wise and
            4'b0001: alu_out = srcA | srcB;     // bit-wise or
            4'b0010: alu_out = srcA + srcB;     // addition
            4'b0110: alu_out = srcA - srcB;     // subtration
            4'b0011: alu_out = srcA ^ srcB;           // XOR
            4'b0111: alu_out = srcA << srcB[4:0];     // SLL (shift left logical)
            4'b0101: alu_out = srcA >> srcB[4:0];     // SRL (shift right logical)
            4'b1011: alu_out = $signed(srcA) >>> srcB[4:0];             // SRA (shift right arithmetic) — needs the signed handling we discussed
            4'b1111: alu_out = (srcA < srcB) ? 1 : 0; // SLT (set less than)
            4'b1000: alu_out = ($unsigned(srcA) < $unsigned(srcB)) ? 1 : 0;     // SLTIU
            4'b1001: alu_out = (srcA != srcB) ? 0 : 1;      // bne
            4'b0100: alu_out = (srcA < srcB) ? 0 : 1;       // blt
            4'b1100: alu_out = (srcA >= srcB) ? 0 : 1;       // bge
            4'b1101: alu_out = ($unsigned(srcA) < $unsigned(srcB)) ? 0 : 1;       // bltu
            4'b1110: alu_out = ($unsigned(srcA) >= $unsigned(srcB)) ? 0 : 1;       // bgeu
            4'b1010: alu_out = (srcB << 12);


            default: alu_out = 32'hxxxxxxxx;    // undefined/error case
        endcase

        if (alu_out == 32'd0) begin
            zero = 1'd1;
        end else begin
            zero = 1'd0;
        end
    end

    
endmodule