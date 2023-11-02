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

// ---------- ---------- ----------

IM instrMem(
    .pc(pc),
    .instr(instr)
);

DM dataMem(
    .clk(clk),
    .address(address),
    .wd(writeData),
    .we(WE),
    .rd(readData)
);

endmodule