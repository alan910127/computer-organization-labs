`timescale 1ns/1ps

module ALU_Ctrl(
    input       [4-1:0] instr,
    input       [2-1:0] ALUOp,
    output reg  [4-1:0] ALU_Ctrl_o
);
/* Write your code HERE */

wire [3-1:0] func3;
assign func3 = instr[2:0];

reg ALU_Ctrl_o;

always @(*) begin
    case (ALUOp)
        2'b00: ALU_Ctrl_o = 4'b0010; //addi
        2'b01: ALU_Ctrl_o = 4'b0110; //branch
        2'b10: begin //R-type
            case (instr)
                4'b0000: ALU_Ctrl_o = 4'b0010; //add
                4'b1000: ALU_Ctrl_o = 4'b0110; //sub
                4'b0111: ALU_Ctrl_o = 4'b0000; //and
                4'b0110: ALU_Ctrl_o = 4'b0001; //or
                4'b0010: ALU_Ctrl_o = 4'b0111; //slt
                default: ALU_Ctrl_o = 4'b0000;
            endcase
        end
        default: ALU_Ctrl_o = 4'b0000;
    endcase
end
endmodule
