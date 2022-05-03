
`timescale 1ns/1ps

module Decoder(
    input   [7-1:0]     instr_i,
    output              RegWrite,
    output              Branch,
    output              Jump,
    output              WriteBack1,
    output              WriteBack0,
    output              MemRead,
    output              MemWrite,
    output              ALUSrcA,
    output              ALUSrcB,
    output  [2-1:0]     ALUOp
);

/* Write your code HERE */

reg regWrite, branch, jump, writeBack0, writeBack1, memRead, memWrite, aluSrcA, aluSrcB, aluOp;

assign RegWrite     = regWrite;
assign Branch       = branch;
assign Jump         = jump;
assign WriteBack0   = writeBack0;
assign WriteBack1   = writeBack1;
assign MemRead      = memRead;
assign MemWrite     = memWrite;
assign ALUSrcA      = aluSrcA;
assign ALUSrcB      = aluSrcB;
assign ALUOp        = aluOp;

always @(instr_i) begin
    case (instr_i)
    7'b0110011: begin // R-type
        regWrite    <= 1'b1;
        branch      <= 1'b0;
        jump        <= 1'b0;
        writeBack1  <= 1'b0;
        writeBack0  <= 1'b0;
        memRead     <= 1'b0;
        memWrite    <= 1'b0;
        aluSrcA     <= 1'b0; // branch = 0 => don't care
        aluSrcB     <= 1'b0;
        aluOp       <= 2'b10;
    end
    7'b0010011: begin // addi
        regWrite    <= 1'b1;
        branch      <= 1'b0;
        jump        <= 1'b0;
        writeBack1  <= 1'b0;
        writeBack0  <= 1'b0;
        memRead     <= 1'b0;
        memWrite    <= 1'b0;
        aluSrcA     <= 1'b0; // branch = 0 => don't care
        aluSrcB     <= 1'b1;
        aluOp       <= 2'b00;
    end
    7'b0000011: begin // Load
        regWrite    <= 1'b1;
        branch      <= 1'b0;
        jump        <= 1'b0;
        writeBack1  <= 1'b0;
        writeBack0  <= 1'b1;
        memRead     <= 1'b1;
        memWrite    <= 1'b0;
        aluSrcA     <= 1'b0; // branch = 0 => don't care
        aluSrcB     <= 1'b1;
        aluOp       <= 2'b00;
    end
    7'b0100011: begin // Store
        regWrite    <= 1'b0;
        branch      <= 1'b0;
        jump        <= 1'b0;
        writeBack1  <= 1'b0; // regWrite = 0 => don't care
        writeBack0  <= 1'b0; // regWrite = 0 => don't care
        memRead     <= 1'b0;
        memWrite    <= 1'b1;
        aluSrcA     <= 1'b0; // branch = 0 => don't care
        aluSrcB     <= 1'b1;
        aluOp       <= 2'b00;
    end
    7'b1100011: begin // branch
        regWrite    <= 1'b0;
        branch      <= 1'b1;
        jump        <= 1'b0;
        writeBack1  <= 1'b0; // regWrite = 0 => don't care
        writeBack0  <= 1'b0; // regWrite = 0 => don't care
        memRead     <= 1'b0;
        memWrite    <= 1'b0;
        aluSrcA     <= 1'b0; // 0 => PC + immediate
        aluSrcB     <= 1'b0;
        aluOp       <= 2'b01;
    end
    7'b1101111: begin // jal rd, imm
        regWrite    <= 1'b1;
        branch      <= 1'b0;
        jump        <= 1'b0;
        writeBack1  <= 1'b1;
        writeBack0  <= 1'b0; // writeBack1 = 1 => don't care
        memRead     <= 1'b0;
        memWrite    <= 1'b0;
        aluSrcA     <= 1'b0; // 0 => PC + immediate
        aluSrcB     <= 1'b0; // writeBack1 = 1 => don't care
        aluOp       <= 2'b00; // writeBack1 = 1 => don't care
    end
    7'b1100111: begin // jalr rd, rs, imm
        regWrite    <= 1'b1;
        branch      <= 1'b0;
        jump        <= 1'b1;
        writeBack1  <= 1'b1;
        writeBack0  <= 1'b0;  // writeBack1 = 1 => don't care
        memRead     <= 1'b0;
        memWrite    <= 1'b0;
        aluSrcA     <= 1'b1;  // 1 => rs + immediate
        aluSrcB     <= 1'b0;  // writeBack1 = 1 => don't care
        aluOp       <= 2'b10; // writeBack1 = 1 => don't care
    end
    default: begin
        regWrite    <= 1'b0;
        branch      <= 1'b0;
        jump        <= 1'b0;
        writeBack1  <= 1'b0;
        writeBack0  <= 1'b0;
        memRead     <= 1'b0;
        memWrite    <= 1'b0;
        aluSrcA     <= 1'b0;
        aluSrcB     <= 1'b0;
        aluOp       <= 2'b00;
    end
    endcase
end

endmodule

