`include "Components/PC.v"
`include "Components/BR.v"
`include "Components/SE.v"
`include "Components/ALU.v"
`include "Components/Adder.v"
`include "Components/Adder16.v"
`include "Components/Mu.v"
`include "Components/Mu4.v"
`include "Components/Mu16.v"

module dataPath(
    //Entradas
    input wire clk,         //magia
    input [31:0] instr,     //de la memoria
    input [31:0] readData,  //de la memoria
    input wire branch,      //de la UC
    input wire jump,        //de la UC
    input [1:0] resSrc,     //de la UC
    input [2:0] ALUControl, //de la UC
    input wire ALUSrc,      //de la UC
    input [1:0] immSrc,     //de la UC
    input wire regWrite,    //de la UC
    //Salidas
    output [15:0] pc,       //a la memoria
    output [15:0] address,  //a la memoria
    output [31:0] writeData,//a la memoria
    output wire zero,       //a la UC
    output wire f7,         //a la UC
    output [2:0] f3,        //a la UC
    output [6:0] op         //a la UC
);

// ---------- Cableciños ----------
wire[15:0] s_addSrc;    //multBranch    -> AdderPCNext
wire[15:0] s_pcNext;    //AdderPCNext   -> multJump, multRes
wire[15:0] s_pcJump;    //AdderPCJump   -> multJump
wire[15:0] s_pcFinal;   //multJump      -> PC
wire[15:0] s_pc;        //PC            -> IM, AdderPCNext, AdderPCJump
wire[31:0] s_srcA;      //BR            -> ALU
wire[31:0] s_rd2;       //BR            -> multSrcB, DM
wire[31:0] s_immExt;    //SE            -> multSrcB, AdderPCJump, multBranch
wire[31:0] s_srcB;      //multSrcB      -> ALU
wire[31:0] s_ALURes;    //ALU           -> DM, multData
wire[31:0] s_res;       //multData      -> BR
// ---------- ---------- ----------

// -------- Varibles --------
reg[15:0] cuatro = 3'b100;
// -------- -------- --------

Mu16 MultBranch(
    .e1(cuatro),
    .e2(s_immExt[15:0]),
    .sel(branch),
    .sal(s_addSrc)
);

Adder16 AdderPCNext(
    .op1(s_addSrc),
    .op2(s_pc),
    .res(s_pcNext)
);

Adder16 AdderPCJump(
    .op1(s_immExt[15:0]),
    .op2(s_pc),
    .res(s_pcJump)
);

Mu16 MultJump(
    .e1(s_pcNext),
    .e2(s_pcJump),
    .sel(jump),
    .sal(s_pcFinal)
);

PC PCReg(
    .clk(clk),
    .pcNext(s_pcFinal),
    .pc(s_pc)
);

BR regBank(
    .clk(clk),
    .a1(instr[19:15]),  //rs1
    .a2(instr[24:20]),  //rs2
    .a3(instr[11:7]),   //rd
    .wd3(s_res),
    .we(regWrite),
    .rd1(s_srcA),
    .rd2(s_rd2)
);

SE sExt(
    .instr(instr),
    .src(immSrc),
    .immExt(s_immExt)
);

Mu MultSrcB(
    .e1(s_rd2),
    .e2(s_immExt),
    .sel(ALUSrc),
    .sal(s_srcB)
);

ALU ALU1(
    .srcA(s_srcA),
    .srcB(s_srcB),
    .ALUControl(ALUControl),
    .zero(zero),
    .res(s_ALURes)
);

Mu4 MultData(
    .e1(s_ALURes),
    .e2(readData),
    .e3(s_pcNext),
    .sel(resSrc),
    .sal(s_res)
);

assign pc = s_pc;
assign address = s_ALURes;
assign writeData = s_rd2;
assign f7 = instr[30];
assign f3 = instr[14:12];
assign op = instr[6:0];

endmodule