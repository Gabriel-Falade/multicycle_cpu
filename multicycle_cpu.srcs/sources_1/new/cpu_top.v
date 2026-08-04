`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/03/2026 09:58:32 PM
// Design Name: 
// Module Name: cpu_top
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


module cpu_top(
    input CLK100MHZ,
    input btn,
    output [3:0] led
    );

    wire [31:0] instr; 
    wire [31:0] full_instr;
    wire pc_write_cond;
    wire pc_write;
    wire zero;
    reg [31:0] pc_next;
    wire [6:0] opcode;
    wire i_or_d;
    wire mem_read;
    wire mem_write;
    wire mem_to_reg;
    wire ir_write;
    wire [1:0] pc_source;
    wire [1:0] alu_op;      // from control
    wire [1:0] alu_src_b;
    wire alu_src_a;
    wire reg_write;
    wire [31:0] write_data;
    wire [31:0] mem_data;
    wire [4:0] rs1;
    wire [4:0] rs2;
    wire [4:0] rd;
    wire [31:0] rs1_data;
    wire [31:0] rs2_data;
    wire [3:0] alu_operator;        // alu control to alu
    wire [31:0] alu_out;
    wire [31:0] mem_address;           //  from mux
    reg [31:0] srcA;
    reg [31:0] srcB;
    wire [31:0] imm_out;
    wire [31:0] alu_result;
    wire [31:0] mdr_out;



    // assign are for continuous assignments 
    // anything assigned procedurally inside any always block
    always @(*) begin
        if (alu_src_a) begin
            srcA = rs1_data;
        end else begin
            srcA = instr;
        end
    end

    assign led = 4'b0000;
    assign mem_address = i_or_d ? alu_out : instr;
    assign write_data = mem_to_reg ? mdr_out : alu_out;

    always @(*) begin
        case (alu_src_b)
            2'b00: srcB = rs2_data;
            2'b01: srcB = 32'd4;
            2'b10: srcB = imm_out;
            default: srcB = 32'hxxxxxxxx;
        endcase
    end

    always @(*) begin
        case (pc_source)
            2'b00: pc_next = alu_result;
            2'b01: pc_next = alu_out;
            2'b10: pc_next = alu_result;
            default: pc_next = 32'hxxxxxxxx;
        endcase
    end

    pc pc_inst(
        .clk(CLK100MHZ),
        .reset(btn),
        .PCWriteCond(pc_write_cond),
        .PCWrite(pc_write),
        .zero(zero),
        .pc_next(pc_next),
        .address(instr)
    );

    control control_inst(
        .clk(CLK100MHZ),
        .reset(btn),
        .opcode(opcode),
        .PCWriteCond(pc_write_cond),
        .PCWrite(pc_write),
        .IorD(i_or_d),
        .MemRead(mem_read),
        .MemWrite(mem_write),
        .IRWrite(ir_write),
        .PCSource(pc_source),
        .ALUOp(alu_op),
        .ALUSrcB(alu_src_b),
        .ALUSrcA(alu_src_a),
        .RegWrite(reg_write)
    );

    mem mem_inst(
        .clk(CLK100MHZ),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .write_data(write_data),
        .address(mem_address),
        .mem_data(mem_data)

    );

    instr_reg instr_reg_inst(
        .clk(CLK100MHZ),
        .reset(btn),
        .mem_data(mem_data),
        .IRWrite(ir_write),
        .opcode(opcode),
        .rs1(rs1),
        .rs2(rs2),
        .rd(rd),
        .full_instr(full_instr)
    );

    regfile regfile_inst(
        .clk(CLK100MHZ),
        .rs1(rs1),
        .rs2(rs2),
        .rd(rd),
        .reg_write(reg_write),
        .write_data(write_data),
        .rs1_data(rs1_data),
        .rs2_data(rs2_data)
    );

    alu alu_inst(
        .srcA(srcA),
        .srcB(srcB),
        .alu_op(alu_operator),
        .zero(zero),
        .alu_out(alu_result)
    );

    alu_control alu_control_inst(
        .full_instr(full_instr),
        .ALUOp(alu_op),
        .alu_control_out(alu_operator)
    );

    ALUOut alu_out_inst(
        .clk(CLK100MHZ),
        .alu_result(alu_result),
        .alu_out(alu_out)
    );

    imm_gen imm_gen_inst(
        .full_instr(full_instr),
        .imm_out(imm_out)
    );

    mem_data_reg mdr_inst(
        .clk(CLK100MHZ),
        .mem_data(mem_data),
        .mdr_out(mdr_out)
    );

endmodule
