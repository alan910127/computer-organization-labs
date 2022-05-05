
`timescale 1ns/1ps

module Decoder(
    input  [7-1:0] instr_i,
    output         RegWrite,
    output         Branch,
    output         Jump,
    output         WriteBack1,
    output         WriteBack0,
    output         MemRead,
    output         MemWrite,
    output         ALUSrcA,
    output         ALUSrcB,
    output [2-1:0] ALUOp
);

/* Write your code HERE */

reg RegWrite, Branch, Jump, WriteBack0, WriteBack1, MemRead, MemWrite, ALUSrcA, ALUSrcB, ALUOp;


always @(instr_i) begin
    case (instr_i)
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
        ALUOp       = 2'b10;
    end
    7'b0010011: begin // addi
        RegWrite    = 1'b1;
        Branch      = 1'b0;
        Jump        = 1'b0;
        WriteBack1  = 1'b0;
        WriteBack0  = 1'b0;
        MemRead     = 1'b0;
        MemWrite    = 1'b0;
        ALUSrcA     = 1'b0; // Branch = 0 => don't care
        ALUSrcB     = 1'b1;
        ALUOp       = 2'b00;
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
        ALUOp       = 2'b00;
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
        ALUOp       = 2'b00;
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
        ALUOp       = 2'b01;
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
        ALUOp       = 2'b00; // WriteBack1 = 1 => don't care
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
        ALUOp       = 2'b00; // WriteBack1 = 1 => don't care
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
        ALUOp       = 2'b00;
    end
    endcase
end

endmodule

