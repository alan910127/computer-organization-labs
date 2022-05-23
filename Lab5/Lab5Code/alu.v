`timescale 1ns/1ps

module alu(
    input                   rst_n,         // negative reset            (input)
    input        [32-1:0]   src1,          // 32 bits source 1          (input)
    input        [32-1:0]   src2,          // 32 bits source 2          (input)
    input        [ 4-1:0]   ALU_control,   // 4 bits ALU control input  (input)
    output reg   [32-1:0]   result,        // 32 bits result            (output)
    output reg              zero           // 1 bit when the output is 0, zero must be set (output)
);

/* Write your code HERE */

wire          Ainvert, Binvert;
wire [ 2-1:0] operation;
wire [32-1:0] A;
wire [32-1:0] B;
wire [32-1:0] addResult;

assign Ainvert   = ALU_control[3];
assign Binvert   = ALU_control[2];
assign operation = ALU_control[1:0];

assign A = (Ainvert) ? ~src1 : src1;
assign B = (Binvert) ? ~src2 : src2;

assign addResult = A + B + Binvert;


always @(*) begin
    case (operation)
        2'b00: result = A & B;
        2'b01: result = A | B;
        2'b10: result = addResult;
        2'b11: result = (addResult[31]) ? 32'b1 : 32'b0;
    endcase
end

always @(result) begin
    zero = (result == 0) ? 1'b1 : 1'b0;
end

endmodule
