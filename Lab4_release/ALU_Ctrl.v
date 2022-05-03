
`timescale 1ns/1ps
/*instr[30,14:12]*/
module ALU_Ctrl(
    input       [4-1:0] instr,
    input       [2-1:0] ALUOp,
    output      [4-1:0] ALU_Ctrl_o
);

wire [2:0] func3;
assign func3 = instr[2:0];

/* Write your code HERE */

reg aluCtrl;
assign ALU_Ctrl_o = aluCtrl;

always @(*) begin
    case (ALUOp)
    2'b00: aluCtrl <= 4'b0010;
    2'b01: aluCtrl <= 4'b0110;
    2'b10: begin
        case (instr)
        4'b0000: aluCtrl <= 4'b0010;
        4'b1000: aluCtrl <= 4'b0110;
        4'b0111: aluCtrl <= 4'b0000;
        4'b0110: aluCtrl <= 4'b0001;
        default: aluCtrl <= 4'b0000;
        endcase
    end
    default: aluCtrl <= 4'b0000;
    endcase
end

endmodule

