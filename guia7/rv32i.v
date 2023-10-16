module rv32i(
    //Entradas
    input wire clk,
    input [31:0] instr,
    input [31:0] readData,

    //Salidas
    output [15:0] pc,
    output wire WE,
    output [15:0] address,
    output [31:0] writeData
);

// ---------- Cableciños ----------
wire pcSrc;
wire[6:0] op;
wire[2:0] f3;
wire f7;
wire regWrite;
wire[1:0] inmSrc;
wire ALUSrc;
wire[2:0] ALUControl;
wire Zero;
wire resSrc;
// ---------- ---------- ----------

UC unitControl(
    .f7(f7),
    .f3(f3),
    .op(op),
    .zero(Zero),
    .pcSrc(pcSrc),
    .resSrc(resSrc),
    .memWrite(WE),
    .ALUcontrol(ALUControl),
    .aluSrc(ALUSrc),
    .inmSrc(inmSrc),
    .regWrite(regWrite)
);

dataPath DataPath(
    .clk(clk),
    .instr(instr),
    .readData(readData),
    .pcSrc(pcSrc),
    .resSrc(resSrc),
    .ALUControl(ALUControl),
    .ALUSrc(ALUSrc),
    .inmSrc(inmSrc),
    .regWrite(regWrite),
    .pc(pc),
    .address(address),
    .writeData(writeData),
    .zero(Zero),
    .f7(f7),
    .f3(f3),
    .op(op)
);

endmodule