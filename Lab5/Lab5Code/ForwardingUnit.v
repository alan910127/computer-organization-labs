`timescale 1ns/1ps
`define SELECT_EXEMEM 2'h2
`define SELECT_IDEXE  2'h1
`define SELECT_ORIGINAL 2'h0

module ForwardingUnit (
    input [5-1:0] IDEXE_RS1,
    input [5-1:0] IDEXE_RS2,
    input [5-1:0] EXEMEM_RD,
    input [5-1:0] MEMWB_RD,
    input [2-1:0] EXEMEM_RegWrite,
    input [2-1:0] MEMWB_RegWrite,
    output reg [2-1:0] ForwardA,
    output reg [2-1:0] ForwardB
);
/* Write your code HERE */

always @(*) begin
    // EXEMEM has priority over MEMWB
    if ((EXEMEM_RegWrite) && (EXEMEM_RD != 0) && (EXEMEM_RD == IDEXE_RS1)) ForwardA = `SELECT_EXEMEM;
    else if ((MEMWB_RegWrite) && (MEMWB_RD != 0) && (MEMWB_RD == IDEXE_RS1)) ForwardA = `SELECT_IDEXE;
    else ForwardA = `SELECT_ORIGINAL;

    if ((EXEMEM_RegWrite) && (EXEMEM_RD != 0) && (EXEMEM_RD == IDEXE_RS2)) ForwardB = `SELECT_EXEMEM;
    else if ((MEMWB_RegWrite) && (MEMWB_RD != 0) && (MEMWB_RD == IDEXE_RS2)) ForwardB = `SELECT_IDEXE;
    else ForwardB = `SELECT_ORIGINAL;
end

endmodule

