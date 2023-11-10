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
wire[6:0] s_op;
wire[2:0] s_f3;
wire s_f7;
wire s_zero;
wire s_branch;
wire s_jump;
wire[1:0] s_resSrc;
wire[2:0] s_ALUControl;
wire s_ALUSrc;
wire[1:0] s_immSrc;
wire s_regWrite;
// ---------- ---------- ----------

reg aux_jump;
initial
    aux_jump <= 0;

UC unitControl(
    .f7(s_f7),
    .f3(s_f3),
    .op(s_op),
    .zero(s_zero),
    .branch(s_branch),
    .jump(s_jump),
    .resSrc(s_resSrc),
    .memWrite(WE),
    .ALUcontrol(s_ALUControl),
    .aluSrc(s_ALUSrc),
    .immSrc(s_immSrc),
    .regWrite(s_regWrite)
);

dataPath DataPath(
    .clk(clk),
    .instr(instr),
    .readData(readData),
    .branch(s_branch),
    .jump(s_jump),
    .resSrc(s_resSrc),
    .ALUControl(s_ALUControl),
    .ALUSrc(s_ALUSrc),
    .immSrc(s_immSrc),
    .regWrite(s_regWrite),
    .pc(pc),
    .address(address),
    .writeData(writeData),
    .zero(s_zero),
    .f7(s_f7),
    .f3(s_f3),
    .op(s_op)
);

assign jump = aux_jump;

endmodule