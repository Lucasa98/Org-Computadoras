module Top(
    //Entradas
    input wire clk,
    input wire Rx,

    //Salidas
    output wire Tx
);

// ---------- Cableciños ----------
wire[31:0] s_instr;
wire[15:0] s_pc;
wire s_WE;
wire[15:0] s_address;
wire[31:0] s_writeData;
wire[31:0] s_readData;
// ---------- ---------- ----------

rv32i RV(
    .clk(clk),
    .instr(s_instr),
    .readData(s_readData),
    .pc(s_pc),
    .WE(s_WE),
    .address(s_address),
    .writeData(s_writeData)
);

mem Memory(
    .clk(clk),
    .pc(s_pc),
    .WE(s_WE),
    .address_virtual(s_address),
    .writeData(s_writeData),
    .i_Rx(Rx),

    //Salidas
    .instr(s_instr),
    .readData(s_readData),
    .o_Tx(Tx)
);

endmodule