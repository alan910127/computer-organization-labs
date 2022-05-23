`timescale 1ns/1ps
module IFID_register (
    input clk_i,
    input rst_i,
    input flush,
    input IFID_write,
    input [31:0] address_i,
    input [31:0] instr_i,
    input [31:0] pc_add4_i,

    output reg [31:0] address_o,
    output reg [31:0] instr_o,
    output reg [31:0] pc_add4_o
);
/* Write your code HERE */

reg [31:0] address_s;
reg [31:0] instr_s;
reg [31:0] pc_add4_s;

always @(posedge clk_i) begin
    if (~rst_i) begin
        address_s <= 32'b0;
        instr_s <= 32'b0;
        pc_add4_s <= 32'b0;
    end
    else if (flush) begin
        address_o <= 32'b0;
        instr_o <= 32'b0;
        pc_add4_o <= 32'b0;
    end
    else if (IFID_write) begin
        address_o <= address_s;
        instr_o <= instr_s;
        pc_add4_o <= pc_add4_s;

        address_s <= address_i;
        instr_s <= instr_i;
        pc_add4_s <= pc_add4_i;
    end
    else begin
        address_o <= address_s;
        instr_o <= instr_s;
        pc_add4_o <= pc_add4_s;
    end
end

endmodule
