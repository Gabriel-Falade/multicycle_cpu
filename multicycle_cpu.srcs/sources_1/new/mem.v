`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/30/2026 06:23:50 PM
// Design Name: 
// Module Name: mem
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: This is the memory unit. If memRead we are reading the 32 bit value
// corresponding to an instruction, if memWrite then we write to memory 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module mem(
    input clk,
    input mem_read,     // content of memory at adress input put into output
    input mem_write,    // content @ address replaced by value of write data  
    input[31:0] write_data,
    input[31:0] address,           // comes from pc module or ALUOUT
    output reg[31:0] mem_data  // data of memeory that was read
    );
  
    // increment for pc of one is a byte
    reg [31:0] my_memory [0:255];   // memory array with 256 locations all 32 bit wide

    // read logic has to be assign since it is updated 
    always @(*) begin
        if (mem_read) begin
            // reading from memory and outputing 32 bit instruction
            mem_data = my_memory[address>>2];
        end
    end
     
     always @(posedge clk) begin
        if (mem_write) begin
            // writing to memory specified by address
            my_memory[address>>2]<= write_data;
        end
    end
endmodule
