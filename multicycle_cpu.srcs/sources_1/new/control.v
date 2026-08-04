`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/03/2026 05:27:27 PM
// Design Name: 
// Module Name: control
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
// anytime assignign something in block need reg

module control(
    input clk,
    input reset,
    input [6:0] opcode,
    output reg PCWriteCond,
    output reg PCWrite,
    output reg IorD,
    output reg MemRead, 
    output reg MemWrite,
    output reg MemtoReg,
    output reg IRWrite,
    output reg [1:0] PCSource,
    output reg [1:0] ALUOp,
    output reg [1:0] ALUSrcB,
    output reg ALUSrcA,
    output reg RegWrite
    );

    reg [3:0] current_state;  // holds state 0-8, needs enough bits (4 bits covers 0-15)
    reg [3:0] next_state;


    always @(posedge clk) begin
        if (reset) begin
            current_state <= 4'd0;
        end else if (!reset) begin
            current_state <= next_state;
        end   
    end

    always @(*) begin
            MemRead = 0; 
            MemWrite = 0; 
            IRWrite = 0; 
            RegWrite = 0;
            ALUSrcA = 0; 
            ALUSrcB = 0; 
            ALUOp = 0; 
            IorD = 0; 
            PCSource = 0;
            PCWrite = 0; 
            PCWriteCond = 0; 
            MemtoReg = 0;

        case (current_state)
            4'd0: begin
                    MemRead = 1;
                    ALUSrcA = 0;
                    IorD = 0;
                    IRWrite = 1;
                    ALUSrcB = 2'b01;
                    ALUOp = 2'b00;
                    PCWrite = 1;
                    PCSource = 0;

                    
                    next_state = 4'd1;
                end
                    
            4'd1: begin                 // decode stage
                    ALUSrcA = 0;
                    ALUSrcB = 2'b10;
                    ALUOp = 2'b00;

                    // lw or sw
                    if (opcode == 7'b0100011 || opcode == 7'b0000011) begin
                        next_state = 4'd2;
                    // R-type instruction
                    end else if (opcode == 7'b0110011) begin
                        next_state = 4'd6;
                    // beq instruction
                    end else if (opcode == 7'b1100011) begin
                        next_state = 4'd8;
                    // jump instructions 
                    end else if (opcode == 7'b1101111) begin
                        next_state = 4'd9;
                    end
                end

                
            4'd2: begin
                    ALUSrcA = 1;
                    ALUSrcB = 2'b10;
                    ALUOp = 2'b00;

                    // both for mem access
                    if (opcode == 7'b0000011) begin
                        next_state = 4'd3;          // mem accses for lw
                    end else if (opcode == 7'b0100011) begin
                        next_state = 4'd5;          // mem access for sw
                    end
            end

            4'd3: begin
                MemRead = 1;
                IorD = 1;
                next_state = 4'd4;
            end

            4'd4: begin
                RegWrite = 1;
                MemtoReg = 1;
                next_state = 4'd0;
            end

            4'd5: begin
                    MemWrite = 1;
                    IorD = 1;
                    next_state = 4'd0;
            end

            4'd6: begin
                    ALUSrcA = 1;
                    ALUSrcB = 2'b00;
                    ALUOp = 2'b10;
                    next_state = 4'd7;
            end

            4'd7: begin
                RegWrite = 1;
                MemtoReg = 0;
                next_state = 4'd0;
            end

            4'd8: begin
                    ALUSrcA = 1;
                    ALUSrcB = 2'b00;
                    ALUOp = 2'b01;
                    PCWriteCond = 1;
                    PCSource = 1;
                    next_state = 4'd0;
            end
        
            4'd9: begin
                    // compute return address (PC + 4)
                    ALUSrcA = 0;
                    ALUSrcB = 2'b01;
                    ALUOp = 2'b00;
                    next_state = 4'd10;
            end

            4'd10: begin
                // writeback return address into rd
                RegWrite = 1;
                MemtoReg = 0;
                next_state = 4'd11;
            end

            4'd11: begin
                // computer jump target
                ALUSrcA  = 0;
                ALUSrcB  = 2'b10;
                ALUOp    = 2'b00;
                PCSource = 2'b10;
                PCWrite  = 1;
                next_state = 4'd0;
            end

            default: next_state = 4'd0;
        endcase
    end
endmodule
