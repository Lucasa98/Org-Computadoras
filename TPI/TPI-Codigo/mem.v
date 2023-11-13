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
    input wire i_Rx,

    // Salidas
    output [31:0] instr,
    output [31:0] readData,
    output wire o_Tx
);

// ---------- Cableciños ----------
wire[1:0] block_select;
wire[15:0] address_physical;
wire DataEnable;
wire StackEnable; 
wire UARTEnable;
wire[31:0] s_DMdata;
wire[31:0] s_UARTdata;
// ---------- ---------- ----------

// Memory Mapping (MMU)
MMU memory_mapping(
    .address_virtual(address_virtual),
    .block_select(block_select),
    .address_physical(address_physical),
    .DataEnable(DataEnable),
    .StackEnable(StackEnable),
    .UARTEnable(UARTEnable)
);

// Data Memory
DM dataMem(
    .clk(clk),
    .address(address_physical),
    .wd(writeData),
    .we(DataEnable), 
    .rd(s_DMdata)
);


// UART 
UART UartModule(
    .clk(clk),
    .i_Rx(i_Rx),
    .address(address_physical),
    .w_data(writeData),
    .we(UARTEnable),
    .r_data(s_UARTdata),
    .o_Tx(o_Tx)
);

// Instruction Memory (IM)
IM instrMem(
    .pc(pc),
    .instr(instr)
);

Mu4 multiplexor(
    .e1(s_DMdata),
    .e3(s_UARTdata),
    .sel(block_select),
    .sal(readData)
);

endmodule