`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/31/2026 06:11:57 PM
// Design Name: 
// Module Name: instr_reg
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


module instr_reg(
    input clk,
    input reset,
    input[31:0] mem_data,     // comes from mem.v
    input IRWrite,
    output reg[6:0] opcode,
    output reg[4:0] rs1,
    output reg[4:0] rs2,
    output reg[4:0] rd,
    output reg[31:0] full_instr
    );
    
    always @(posedge clk) begin
        if (reset) begin
            opcode<= 7'b0000000;
            rs1<= 5'b00000;
            rs2<= 5'b00000;
            rd<= 5'b00000;
            full_instr<= 32'h0000000;
        end else if (IRWrite) begin
            opcode<= mem_data[6:0];
            rs1<= mem_data[19:15];
            rs2<= mem_data[24:20];
            rd<= mem_data[11:7];
            full_instr<= mem_data[31:0];
        end
   end
endmodule