module Top(
    //Entradas
    input wire clk,

    //Salidas
    output [31:0] sal,
    output [15:0] addressSal
);

// ---------- Cableciños ----------
wire[31:0] instr;
wire[15:0] pc;
wire[15:0] address;
wire[31:0] writeData;
wire[31:0] readData;
// ---------- ---------- ----------

rv32i RV(
    .clk(clk),
    .instr(instr),
    .readData(readData),
    .pc(pc),
    .WE(WE),
    .address(address),
    .writeData(writeData)
);

assign sal = writeData;
assign addressSal = address;

endmodule