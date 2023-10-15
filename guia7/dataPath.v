`include "Components/PC.v"
`include "Components/BR.v"
`include "Components/SE.v"
`include "Components/ALU.v"
`include "Components/Adder.v"
`include "Components/Mu.v"

module dataPath(
    //Entradas
    input wire clk,         //magia
    input [31:0] instr,     //de la memoria?
    input [31:0] readData,  //de la memoria?
    input wire pcSrc,       //de la UC
    input wire resSrc,      //de la UC
    input wire memWrite,    //de la UC
    input [2:0] ALUControl, //de la UC
    input wire ALUSrc,      //de la UC
    input [1:0] inmSrc,     //de la UC
    input wire regWrite,    //de la UC
    //Salidas
    output wire zero,       //a la UC
    output wire f7,         //a la UC
    output [2:0] f3,        //a la UC
    output [6:0] op         //a la UC
);

// ---------- Cableciños ----------
wire[15:0] pcNext = 0;  //multPC    -> pc
wire[15:0] pc = 0;      //pc        -> IM, PCadd4, PCaddImm
wire[31:0] wd3 = 0;     //multData  -> BR
wire[31:0] rd1 = 0;     //BR        -> ALU
wire[31:0] rd2 = 0;     //BR        -> multSrcB, DM
wire[31:0] immExt = 0;  //SE        -> multSrcB, PCaddImm
wire[31:0] srcB = 0;    //multSrcB  -> ALU
wire[31:0] ALUres = 0;  //ALU       -> DM, multData
wire[31:0] add4 = 0;    //PCadd4    -> multPC
wire[31:0] addImm = 0;  //PCaddImm  -> multPC
// ---------- ---------- ----------

// -------- Varibles --------
reg[31:0] cuatro = 3'b100;
// -------- -------- --------

PC Pcounter(
    .clk(clk),
    .pcNext(pcNext),
    .pc(pc)
);

BR regBank(
    .clk(clk),
    .a1(instr[19:15]),
    .a2(instr[24:20]),
    .a3(instr[11:7]),
    .wd3(wd3),
    .we(regWrite),
    .rd1(rd1),
    .rd2(rd2)
);

SE sExt(
    .clk(clk),
    .imm({7'b0,instr[31:7]}),
    .src(inmSrc),
    .immExt(immExt)
);

ALU ALU1(
    .srcA(rd1),
    .srcB(srcB),
    .ALUControl(ALUControl),
    .res(ALUres)
);

Adder PCadd4(
    .op1({16'b0,pc}),
    .op2(cuatro),
    .res(add4)
);

Adder PCaddImm(
    .op1({16'b0,pc}),
    .op2(immExt),
    .res(addImm)
);

Mu multPC(
    .e1(add4),
    .e2(addImm),
    .sel(pcSrc),
    .sal(pcNext[15:0])
);

Mu multSrcB(
    .e1(rd2),
    .e2(immExt),
    .sel(ALUSrc),
    .sal(srcB)
);

Mu multData(
    .e1(readData),
    .e2(ALUres),
    .sel(resSrc),
    .sal(wd3)
);

always @(*)
begin
    
end

endmodule