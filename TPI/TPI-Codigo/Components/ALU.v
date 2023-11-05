module ALU(
    input [31:0] srcA,
    input [31:0] srcB,
    input [2:0] ALUControl,
    output wire zero,
    output [31:0] res
);

reg [31:0] aux = 0;

always @(*)
begin
    case (ALUControl)
        3'b000:
            aux = srcA+srcB;
        3'b001:
            aux = srcA-srcB;
        3'b010:
            aux = srcA && srcB;
        3'b011:
            aux = srcA || srcB;
        default:
            aux = srcA;
    endcase
end

assign zero = 0;
assign res = aux;

endmodule