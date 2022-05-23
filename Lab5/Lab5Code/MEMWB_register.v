`timescale 1ns/1ps
module MEMWB_register (
    input clk_i,
    input rst_i,
    input [2:0] WB_i,
    input [31:0] DM_i,
    input [31:0] alu_ans_i,
    input [4:0] WBreg_i,
    input [31:0] pc_add4_i,

    output reg [2:0] WB_o,
    output reg [31:0] DM_o,
    output reg [31:0] alu_ans_o,
    output reg [4:0] WBreg_o,
    output reg [31:0] pc_add4_o
);
/* Write your code HERE */

reg [2:0] WB_s;
reg [31:0] DM_s;
reg [31:0] alu_ans_s;
reg [4:0] WBreg_s;
reg [31:0] pc_add4_s;

always @(posedge clk_i) begin
    WB_o <= WB_s;
    DM_o <= DM_s;
    alu_ans_o <= alu_ans_s;
    WBreg_o <= WBreg_s;
    pc_add4_o <= pc_add4_s;

    WB_s <= WB_i;
    DM_s <= DM_i;
    alu_ans_s <= alu_ans_i;
    WBreg_s <= WBreg_i;
    pc_add4_s <= pc_add4_i;
end

always(posedge clk_i) begin
    if(~rst_i) begin
        WB_s <= 0;
        DM_s <= 0;
        alu_ans_s <= 0;
        WBreg_s <= 0;
        pc_add4_s <= 0;
    end
end
endmodule
