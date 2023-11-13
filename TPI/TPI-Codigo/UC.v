`include "Decos/aluDeco.v"
`include "Decos/mainDeco.v"

module UC(
    input wire f7,
    input [2:0] f3,
    input [6:0] op,
    input wire zero,
    output wire branch,
    output wire jump,
    output [1:0] resSrc,
    output wire memWrite,
    output [2:0] ALUcontrol,
    output wire aluSrc,
    output [1:0] immSrc,
    output wire regWrite
);

wire[1:0] ALUop;
wire s_branch;
reg r_branch;

initial
    r_branch = 0;

mainDeco MainDecoder(
    .op(op),
    .branch(s_branch),
    .jump(jump),
    .resSrc(resSrc),
    .memWrite(memWrite),
    .aluSrc(aluSrc),
    .immSrc(immSrc),
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
    r_branch = s_branch && zero;

assign branch = r_branch;
endmodule