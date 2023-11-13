module ALU(
    input [31:0] srcA,
    input [31:0] srcB,
    input [2:0] ALUControl,
    output wire zero,
    output [31:0] res
);

reg [31:0] aux = 0;
reg aux_zero = 0;

always @(*)
begin
    case (ALUControl)
        3'b000:
            begin
                aux = srcA+srcB;
                aux_zero <= 0;
            end
        3'b001:
            begin
                aux = srcA-srcB;
                aux_zero <= 0;
            end
        3'b010:
            begin
                aux = srcA && srcB;
                aux_zero <= 0;
            end
        3'b011:
            begin
                aux = srcA || srcB;
                aux_zero <= 0;
            end
        3'b100:
            begin
                aux_zero <= srcA == srcB;
            end
        3'b101:
            begin
                aux = srcB > srcA;
                aux_zero <=  srcB > srcA;
            end
        default:
            begin
                aux = srcA;
                aux_zero <= 0;
            end
    endcase
    
end

assign zero = aux_zero;
assign res = aux;

endmodule