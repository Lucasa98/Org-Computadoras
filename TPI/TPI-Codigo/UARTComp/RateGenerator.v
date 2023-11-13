module RateGenerator(
    input wire clk,
    output wire tick
);
//conexoes//
reg [38:0] r_reg;
wire [38:0] r_next;

initial
begin
    r_reg <= 0;
end
//body
always @(posedge clk)
    r_reg <= r_next;

// next-state logic
assign r_next = (r_reg == 38)? 0 : r_reg + 1;
//output logic
//assign q = r_reg;
assign tick = (r_reg == 38) ? 1'b1 : 1'b0;
endmodule