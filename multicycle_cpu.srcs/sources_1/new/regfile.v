`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/30/2026 07:00:05 PM
// Design Name: 
// Module Name: regfile
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


module regfile(
    input clk,
    input[4:0] rs1,
    input[4:0] rs2,
    input[4:0] rd,
    input reg_write,
    input[31:0] write_data,
    output reg[31:0] rs1_data,
    output reg[31:0] rs2_data
    );
    
    // defining of registers 
    reg [31:0] my_reg [0:31];
    
    always @(*) begin
        rs1_data = my_reg[rs1];
        rs2_data = my_reg[rs2];
    end 
    
    always @(posedge clk) begin
        if (reg_write) begin
            my_reg[rd] <= write_data;
        end
    end
endmodule
