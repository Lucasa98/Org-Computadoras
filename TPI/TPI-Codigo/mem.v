`include "Mems/DM.v"
`include "Mems/IM.v"

module mem(
    //Entradas
    input wire clk,
    input [15:0] pc,
    input wire WE,
    input [15:0] address,
    input [31:0] writeData,

    //Salidas
    output [31:0] instr,
    output [31:0] readData
);

// ---------- Cableciños ----------
wire[31:0] DEBUGinstr16;
wire[31:0] DEBUGinstr20;
// ---------- ---------- ----------

IM instrMem(
    .pc(pc),
    .instr(instr),
    .DEBUGinstr16(DEBUGinstr16),
    .DEBUGinstr20(DEBUGinstr20)
);

DM dataMem(
    .clk(clk),
    .address(address),
    .wd(writeData),
    .we(WE),
    .rd(readData)
);

endmodule