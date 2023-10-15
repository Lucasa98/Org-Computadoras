module Mu(
    input [31:0] e1,
    input [31:0] e2,
    input wire sel,
    output [31:0] sal
);
reg [31:0] aux;

always@(*)
    begin
        case(sel)
            1'b0:
                aux = e1;
            1'b1:
                aux = e2;
        endcase
    end
assign sal = aux;

endmodule