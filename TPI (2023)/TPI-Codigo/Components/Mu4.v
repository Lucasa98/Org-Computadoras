module Mu4(
    input [31:0] e1,
    input [31:0] e2,
    input [31:0] e3,
    input [31:0] e4,
    input [1:0] sel,
    output [31:0] sal
);
reg [31:0] aux;

always@(*)
    begin
        case(sel)
            2'b00:
                aux = e1;
            2'b01:
                aux = e2;
            2'b10:
                aux = e3;
            2'b11:
                aux = e4;
        endcase
    end
assign sal = aux;

endmodule