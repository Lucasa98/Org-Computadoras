`include "Components/PC.v"
`include "Components/BR.v"
`include "Components/SE.v"
`include "Components/ALU.v"
`include "Components/Adder.v"
`include "Components/Adder16.v"
`include "Components/Mu.v"
`include "Components/Mu16.v"

module dataPath(
    //Entradas
    input wire clk,         //magia
    input [31:0] instr,     //de la memoria
    input [31:0] readData,  //de la memoria
    input wire pcSrc,       //de la UC
    input wire resSrc,      //de la UC  (para el jal necesita 2 bits)
    //input wire memWrite,  //de la UC  ---En realidad va directo a la memoria---
    input [2:0] ALUControl, //de la UC
    input wire ALUSrc,      //de la UC
    input [1:0] inmSrc,     //de la UC
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
wire[15:0] s_pcNext;  //multPC    -> pc
wire[15:0] s_pc;   //pc        -> IM, PCadd4, PCaddImm
wire[31:0] s_wd3;     //multData  -> memoria
wire[31:0] s_rd1;     //BR        -> ALU
wire[31:0] s_rd2;     //BR        -> multSrcB, DM
wire[31:0] s_immExt;  //SE        -> multSrcB, PCaddImm
wire[31:0] s_srcB;    //multSrcB  -> ALU
wire[31:0] s_ALUres;  //ALU       -> DM, multData
wire[15:0] s_add4;    //PCadd4    -> multPC
wire[31:0] s_addImm;  //PCaddImm  -> multPC

wire[31:0] DEBUGx0;
wire[31:0] DEBUGx8;
// ---------- ---------- ----------

// -------- Varibles --------
reg[15:0] cuatro = 3'b100;
// -------- -------- --------

PC PCounter(
    .clk(clk),
    .pcNext(s_pcNext),
    .pc(s_pc)
);

BR regBank(
    .clk(clk),
    .a1(instr[19:15]),  //rs1
    .a2(instr[24:20]),  //rs2
    .a3(instr[11:7]),   //rd
    .wd3(s_wd3),
    .we(regWrite),
    .rd1(s_rd1),
    .rd2(s_rd2),
    .DEBUGx0(DEBUGx0),
    .DEBUGx8(DEBUGx8)
);

SE sExt(
    .instr(instr),
    .src(inmSrc),
    .immExt(s_immExt)
);

ALU ALU1(
    .srcA(s_rd1),
    .srcB(s_srcB),
    .ALUControl(ALUControl),
    .res(s_ALUres)
);

Adder16 PCadd4(
    .op1(s_pc),
    .op2(cuatro),
    .res(s_add4)
);

Adder16 PCaddImm(
    .op1(s_pc),
    .op2(s_immExt),
    .res(s_addImm)
);

Mu16 multPC(
    .e1(s_add4),
    .e2(s_addImm),
    .sel(pcSrc),
    .sal(s_pcNext)
);

Mu multSrcB(
    .e1(s_rd2),
    .e2(s_immExt),
    .sel(ALUSrc),
    .sal(s_srcB)
);

Mu multData(
    .e1(s_ALUres),
    .e2(readData),
    .sel(resSrc),
    .sal(s_wd3)
);

assign pc = s_pc;
assign address = s_ALUres;
assign writeData = s_rd2;
assign zero = 0;
assign f7 = instr[30];
assign f3 = instr[14:12];
assign op = instr[6:0];

endmodule