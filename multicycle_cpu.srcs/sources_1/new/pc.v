`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/28/2026 07:01:39 PM
// Design Name: 
// Module Name: pc
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


module pc(
    input clk,    // clock 
    input reset,        // reset
    input PCWriteCond,  // from Control module
    input PCWrite,      // from Control Module
    input zero,         // from ALU
    input[31:0] pc_next,
    output reg[31:0] address      // since assign inside always blocked need to be 
    );
    
    assign pc_write_cond = (zero && PCWriteCond) || PCWrite;

    always @(posedge clk) begin
        if (reset) begin
            address <= 32'h00000000;
        end else if (pc_write_cond) begin
            address <= pc_next;
         end else begin
            address <= address;
        end
       end
endmodule
