`include "Mems/DM.v"
`include "Mems/IM.v"
`include "Mems/MMU.v"
module mem(
    // Entradas
    input wire clk,
    input [15:0] pc,
    input wire WE,
    input [15:0] address_virtual,
    input [31:0] writeData,

    // Salidas
    output [31:0] instr,
    output [31:0] readData
);

// ---------- Cableciños ----------
wire[1:0] block_select;
wire[15:0] address_physical;
wire DataEnable;
wire StackEnable; 
wire MMIOEnable;
// ---------- ---------- ----------

// Memory Mapping (MMU)
MMU memory_mapping(
    .address_virtual(address_virtual),
    .block_select(block_select),
    .address_physical(address_physical),
    .DataEnable(DataEnable),
    .StackEnable(StackEnable),
    .MMIOEnable(MMIOEnable)
);

// Data Memory
DM dataMem(
    .clk(clk),
    .address(address_physical),
    .wd(writeData),
    .we(DataEnable), 
    .rd(readData)
);

// MMIO Memory
/* DM MMIO(
    .clk(clk),
    .address(address_physical),
    .wd(writeData),
    .we(MMIOEnable), 
    .rd(readData)
); */

// Instruction Memory (IM)
IM instrMem(
    .pc(pc),
    .instr(instr)
);

endmodule