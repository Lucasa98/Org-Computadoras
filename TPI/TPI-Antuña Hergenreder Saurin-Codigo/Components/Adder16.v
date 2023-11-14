module Adder16(
    input [15:0] op1,
    input [15:0] op2,
    output [15:0] res
);

assign res = op1+op2;

endmodule