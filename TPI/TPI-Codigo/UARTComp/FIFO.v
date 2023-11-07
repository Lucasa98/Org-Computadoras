module FIFO(
    input [7:0] w_data,
    input wire wr,
    input wire rd,
    output wire empty,
    output [7:0] r_data
);

reg[7:0] aux = 0;
reg[7:0] data = 0;

always @(posedge wr)
begin
    data <= w_data;
end

always @(posedge rd)
begin
    aux <= data;
end

assign r_data = aux;
endmodule