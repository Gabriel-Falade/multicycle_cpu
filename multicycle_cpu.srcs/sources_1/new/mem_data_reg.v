`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/31/2026 09:50:19 PM
// Design Name: Gabriel Falade
// Module Name: mem_data_reg
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Holds data from memory  
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module mem_data_reg(
    input clk,
    input[31:0] mem_data,
    output reg[31:0] mdr_out
    );
   
    always @(posedge clk) begin
        mdr_out <= mem_data;
    end
endmodule
