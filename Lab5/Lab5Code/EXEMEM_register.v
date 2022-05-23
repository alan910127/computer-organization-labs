`timescale 1ns/1ps
module EXEMEM_register (
    input clk_i,
	input rst_i,
	input [31:0] instr_i,
	input [2:0] WB_i,
	input [1:0] Mem_i,
	input zero_i,
	input [31:0] alu_ans_i,
	input [31:0] rtdata_i,
	input [4:0] WBreg_i,
	input [31:0] pc_add4_i,

	output reg [31:0] instr_o,
	output reg [2:0] WB_o,
	output reg [1:0] Mem_o,
	output reg zero_o,
	output reg [31:0] alu_ans_o,
	output reg [31:0] rtdata_o,
	output reg [4:0] WBreg_o,
	output reg [31:0] pc_add4_o
);
/* Write your code HERE */

reg [31:0] instr_s;
reg [2:0] WB_s;
reg [1:0] Mem_s;
reg zero_s;
reg [31:0] alu_ans_s;
reg [31:0] rtdata_s;
reg [4:0] WBreg_s;
reg [31:0] pc_add4_s;

always @(posedge clk_i) begin
	if (~rst_i) begin
		instr_s <= 0;
		WB_s <= 0;
		Mem_s <= 0;
		zero_s <= 0;
		alu_ans_s <= 0;
		rtdata_s <= 0;
		WBreg_s <= 0;
		pc_add4_s <= 0;
	end
	else begin
		instr_o <= instr_s;
		WB_o <= WB_s;
		Mem_o <= Mem_s;
		zero_o <= zero_s;
		alu_ans_o <= alu_ans_s;
		rtdata_o <= rtdata_s;
		WBreg_o <= WBreg_s;
		pc_add4_o <= pc_add4_s;

		instr_s <= instr_i;
		WB_s <= WB_i;
		Mem_s <= Mem_i;
		zero_s <= zero_i;
		alu_ans_s <= alu_ans_i;
		rtdata_s <= rtdata_i;
		WBreg_s <= WBreg_i;
		pc_add4_s <= pc_add4_i;
	end
	
end



endmodule
