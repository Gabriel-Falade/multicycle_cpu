`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/01/2026 11:28:26 PM
// Design Name: 
// Module Name: ALUOut
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Output of alu module
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module ALUOut(
    input clk,
    input [31:0] alu_result,
    output reg [31:0] alu_out
    );

    always @(posedge clk) begin
        alu_out<= alu_result;
    end
endmodule
