
`timescale 1ns/1ps
/*instr[30,14:12]*/
module ALU_Ctrl(
    input  [4-1:0] instr,
    input  [2-1:0] ALUOp,
    output [4-1:0] ALU_Ctrl_o
);

wire [3-1:0] func3;
assign func3 = instr[2:0];

/* Write your code HERE */

reg aluCtrl;
assign ALU_Ctrl_o = aluCtrl;

always @(*) begin
    case (ALUOp)
    2'b00: aluCtrl = 4'b0010; //addi
    2'b01: aluCtrl = 4'b0110; //branch
    2'b10: begin //R-type
        case (instr)
        4'b0000: aluCtrl = 4'b0010; //add
        4'b1000: aluCtrl = 4'b0110; //sub
        4'b0111: aluCtrl = 4'b0000; //and
        4'b0110: aluCtrl = 4'b0001; //or
        4'b0010: aluCtrl = 4'b0111; //slt
        default: aluCtrl = 4'b0000;
        endcase
    end
    default: aluCtrl = 4'b0000;
    endcase
end

endmodule

