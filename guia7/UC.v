`include "Decos/aluDeco.v"
`include "Decos/mainDeco.v"

module UC(
    input wire f7,
    input [2:0] f3,
    input [6:0] op,
    input wire zero,
    output wire pcSrc,
    output wire branch,
    output [1:0] resSrc,
    output wire memWrite,
    output [2:0] ALUcontrol,
    output wire aluSrc,
    output [1:0] inmSrc,
    output wire regWrite
);

wire[1:0] ALUop = 0;

reg pcSrcAux = 0;

mainDeco MainDecoder(
    .op(op),
    .branch(branch),
    .resSrc(resSrc),
    .memWrite(memWrite),
    .aluSrc(aluSrc),
    .inmSrc(inmSrc),
    .regWrite(regWrite),
    .aluOp(ALUop)
);

aluDeco ALUDecoder(
    .op(op[5]),
    .f7(f7),
    .f3(f3),
    .aluOp(ALUop),
    .aluControl(ALUcontrol)
);

always @(*)
begin
    pcSrcAux = zero && branch;
end

assign pcSrc = pcSrcAux;

endmodule