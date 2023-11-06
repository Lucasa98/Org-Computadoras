module FIFO(
    input [7:0] w_data,
    input wire wr,
    input wire rd,
    output wire empty,
    output [7:0] r_data
);

reg [7:0] data;

always @(posedge wr)
begin
    data <= w_data;
end
always @(posedge rd)
begin
    data = 0;
end

endmodule