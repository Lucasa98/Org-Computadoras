/*module contador (
    src=0 => I-Type
    src=1 => S-Type
);*/
module SE(
    input wire clk,
    input [31:0] imm,
    input [1:0] src,
    output [31:0] immExt
);

reg[31:0] immaux=0;

always @(posedge clk)
begin
    case(src)
        2'b00:  //I-Type
        begin
            immaux = {{20{imm[31]}}, imm[31:20]};
        end
        2'b01:  //S-Type
        begin
            immaux = {{20{imm[31]}}, imm[31:25], imm[11:7]};
        end
        2'b10:  //B-Type
        begin
            immaux = {{19{imm[31]}}, imm[31], imm[7], imm[30:25], imm[11:8], 1'b0};
        end
        2'b11:  //J-Type
        begin

        end
        default: immaux - 32'bx;
    endcase
end

assign immExt = immaux;

endmodule