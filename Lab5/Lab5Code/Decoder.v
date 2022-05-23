`timescale 1ns/1ps

module Decoder(
    input [32-1:0]  instr_i,
    output reg         Branch,
    output reg         ALUSrc,
    output reg         RegWrite,
    output reg [2-1:0] ALUOp,
    output reg         MemRead,
    output reg         MemWrite,
    output reg         MemtoReg,
    output reg         Jump
);

//Internal Signals
wire    [7-1:0]     opcode;
wire    [3-1:0]     funct3;
wire    [3-1:0]     Instr_field;
wire    [9:0]       Ctrl_o;

/* Write your code HERE */

assign opcode = instr_i[6:0];


always @(opcode) begin
    case (opcode)
        7'b0110011: begin // R-type
            RegWrite    = 1'b1;
            Branch      = 1'b0;
            Jump        = 1'b0;
            WriteBack1  = 1'b0;
            WriteBack0  = 1'b0;
            MemRead     = 1'b0;
            MemWrite    = 1'b0;
            ALUSrcA     = 1'b0; // Branch = 0 => don't care
            ALUSrcB     = 1'b0;
            ALUOp       = 2'h2;
        end
        7'b0010011: begin // I-type
            RegWrite    = 1'b1;
            Branch      = 1'b0;
            Jump        = 1'b0;
            WriteBack1  = 1'b0;
            WriteBack0  = 1'b0;
            MemRead     = 1'b0;
            MemWrite    = 1'b0;
            ALUSrcA     = 1'b0; // Branch = 0 => don't care
            ALUSrcB     = 1'b1;
            ALUOp       = 2'h0;
        end
        7'b0000011: begin // Load
            RegWrite    = 1'b1;
            Branch      = 1'b0;
            Jump        = 1'b0;
            WriteBack1  = 1'b0;
            WriteBack0  = 1'b1;
            MemRead     = 1'b1;
            MemWrite    = 1'b0;
            ALUSrcA     = 1'b0; // Branch = 0 => don't care
            ALUSrcB     = 1'b1;
            ALUOp       = 2'h0;
        end
        7'b0100011: begin // Store
            RegWrite    = 1'b0;
            Branch      = 1'b0;
            Jump        = 1'b0;
            WriteBack1  = 1'b0; // RegWrite = 0 => don't care
            WriteBack0  = 1'b0; // RegWrite = 0 => don't care
            MemRead     = 1'b0;
            MemWrite    = 1'b1;
            ALUSrcA     = 1'b0; // Branch = 0 => don't care
            ALUSrcB     = 1'b1;
            ALUOp       = 2'h0;
        end
        7'b1100011: begin // Branch
            RegWrite    = 1'b0;
            Branch      = 1'b1;
            Jump        = 1'b0;
            WriteBack1  = 1'b0; // RegWrite = 0 => don't care
            WriteBack0  = 1'b0; // RegWrite = 0 => don't care
            MemRead     = 1'b0;
            MemWrite    = 1'b0;
            ALUSrcA     = 1'b0; // 0 => PC + immediate
            ALUSrcB     = 1'b0;
            ALUOp       = 2'h1;
        end
        7'b1101111: begin // jal rd, imm
            RegWrite    = 1'b1;
            Branch      = 1'b0;
            Jump        = 1'b1;
            WriteBack1  = 1'b1;
            WriteBack0  = 1'b0; // WriteBack1 = 1 => don't care
            MemRead     = 1'b0;
            MemWrite    = 1'b0;
            ALUSrcA     = 1'b0; // 0 => PC + immediate
            ALUSrcB     = 1'b0; // WriteBack1 = 1 => don't care
            ALUOp       = 2'h0; // WriteBack1 = 1 => don't care
        end
        7'b1100111: begin // jalr rd, rs, imm
            RegWrite    = 1'b1;
            Branch      = 1'b0;
            Jump        = 1'b1;
            WriteBack1  = 1'b1;
            WriteBack0  = 1'b0;  // WriteBack1 = 1 => don't care
            MemRead     = 1'b0;
            MemWrite    = 1'b0;
            ALUSrcA     = 1'b1;  // 1 => rs + immediate
            ALUSrcB     = 1'b0;  // WriteBack1 = 1 => don't care
            ALUOp       = 2'h0; // WriteBack1 = 1 => don't care
        end
        default: begin
            RegWrite    = 1'b0;
            Branch      = 1'b0;
            Jump        = 1'b0;
            WriteBack1  = 1'b0;
            WriteBack0  = 1'b0;
            MemRead     = 1'b0;
            MemWrite    = 1'b0;
            ALUSrcA     = 1'b0;
            ALUSrcB     = 1'b0;
            ALUOp       = 2'h0;
        end
    endcase
end
endmodule







