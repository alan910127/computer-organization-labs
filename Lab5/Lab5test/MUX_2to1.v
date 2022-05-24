`timescale 1ns/1ps

module MUX_2to1 #(parameter size = 32) (
    input       [size-1:0] data0_i,
    input       [size-1:0] data1_i,
    input                select_i,
    output reg  [size-1:0] data_o
);
/* Write your code HERE */

always @(*) begin
    case (select_i) 
    1'h0: data_o = data0_i;
    1'h1: data_o = data1_i;
    endcase
end

endmodule

