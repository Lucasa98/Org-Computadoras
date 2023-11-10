`include "Mems/DM.v"
`include "Mems/IM.v"
`include "Mems/MMU.v"
`include "UARTComp/Converter.v"
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
wire UARTWEnable;
wire [7:0]readAux;
wire [7:0]writeDataAux;
// ---------- ---------- ----------
// ----------- Banderas -----------
wire Rfull;
wire rxempty;
// ----------- -------- -----------

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

// converter
Converter Conv(
    .i_8bits(readAux),
    .i_32bits(writeData),
    .o_8bits(writeDataAux), 
    .o_32bits(readData)
);
// UART 
UART UartModule(
    .clk(clk),
    .address(address_physical),
    .w_data(writeDataAux),
    .we(UARTWEnable),
    .r_data(readAux),
    .rx_empty(rxempty),
    .full(Rfull)
);

// Instruction Memory (IM)
IM instrMem(
    .pc(pc),
    .instr(instr)
);

endmodule