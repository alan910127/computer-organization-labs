`timescale 1ns/1ps
module IDEXE_register (
    input clk_i,
    input rst_i,
    input [31:0] instr_i,
    input [2:0] WB_i,
    input [1:0] Mem_i,
    input [2:0] Exe_i,
    input [31:0] data1_i,
    input [31:0] data2_i,
    input [31:0] immgen_i,
    input [3:0] alu_ctrl_instr,
    input [4:0] WBreg_i,
    input [31:0] pc_add4_i,

    output reg [31:0] instr_o,
    output reg [2:0] WB_o,
    output reg [1:0] Mem_o,
    output reg [2:0] Exe_o,
    output reg [31:0] data1_o,
    output reg [31:0] data2_o,
    output reg [31:0] immgen_o,
    output reg [3:0] alu_ctrl_input,
    output reg [4:0] WBreg_o,
    output reg [31:0] pc_add4_o
);
/* Write your code HERE */

reg [31:0] instr_s;
reg [2:0] WB_s;
reg [1:0] Mem_s;
reg [2:0] Exe_s;
reg [31:0] data1_s;
reg [31:0] data2_s;
reg [31:0] immgen_s;
reg [3:0] alu_ctrl_s;
reg [4:0] WBreg_s;
reg [31:0] pc_add4_s;

always @(posedge clk_i) begin
    if (~rst_i) begin
        instr_s <= 32'b0;
        WB_s <= 3'b0;
        Mem_s <= 2'b0;
        Exe_s <= 2'b0;
        data1_s <= 32'b0;
        data2_s <= 32'b0;
        immgen_s <= 32'b0;
        alu_ctrl_s <= 4'b0;
        WBreg_s <= 4'b0;
        pc_add4_s <= 32'b0;
    end
    else begin
        instr_o <= instr_s;
        WB_o <= WB_s;
        Mem_o <= Mem_s;
        Exe_o <= Exe_s;
        data1_o <= data1_s;
        data2_o <= data2_s;
        immgen_o <= immgen_s;
        alu_ctrl_input <= alu_ctrl_s;
        WBreg_o <= WBreg_s;
        pc_add4_o <= pc_add4_s;

        instr_s <= instr_i;
        WB_s <= WB_i;
        Mem_s <= Mem_i;
        Exe_s <= Exe_i;
        data1_s <= data1_i;
        data2_s <= data2_i;
        immgen_s <= immgen_i;
        alu_ctrl_s <= alu_ctrl_instr;
        WBreg_s <= WBreg_i;
        pc_add4_s <= pc_add4_i;
    end
end

endmodule
