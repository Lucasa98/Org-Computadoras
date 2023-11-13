module Converter(
    input [7:0] i_8bits,
    input [31:0] i_32bits,
    output reg[7:0] o_8bits,
    output reg[31:0] o_32bits
);

initial
begin
    o_8bits <= 0;
    o_32bits <= 0;
end

always@(*)
begin
    o_8bits <= i_32bits;
    o_32bits <= i_8bits;
end

endmodule