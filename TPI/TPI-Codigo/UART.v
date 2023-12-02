`include "UARTComp/RBuffer.v"
`include "UARTComp/TBuffer.v"
`include "UARTComp/RateGenerator.v"
`include "UARTComp/Receiver2.v"
`include "UARTComp/Transmitter2.v"
`include "UARTComp/Converter.v"

module UART(
    input wire clk,
    input wire i_Rx,
    input [15:0] address,
    input [31:0] w_data,
    input wire we,
    output [31:0] r_data,
    output wire o_Tx,

    output [7:0] DEBUGBuffer0,
    output [7:0] DEBUGBuffer1,
    output [7:0] DEBUGBuffer2,
    output [7:0] DEBUGBuffer3,
    output [7:0] DEBUGBuffer4,
    output [7:0] DEBUGBuffer5
);

//----------cableciños----------
wire[7:0] s_dout;
wire s_rx_done_tick;
wire[7:0] s_din;
wire s_tx_done_tick;
wire s_tx_start;
wire s_tick;

wire [7:0]readAux;
wire [7:0]writeDataAux;
//------------------------------

// converter
Converter Conv(
    .i_8bits(readAux),
    .i_32bits(w_data),
    .o_8bits(writeDataAux), 
    .o_32bits(r_data)
);

RateGenerator baudGen(
    .clk(clk),
    .tick(s_tick)
);

Receiver2 receiver(
    .clk(clk),
    .rx(i_Rx),
    .s_tick(s_tick),
    .rx_done_tick(s_rx_done_tick),
    .dout(s_dout)
);

Transmitter2 transmitter(
    .clk(clk),
    .tx_start(s_tx_start),
    .s_tick(s_tick),
    .din(s_din),
    .tx_done_tick(s_tx_done_tick),
    .tx(o_Tx)
);

RBuffer rbuffer(
    .clk(clk),
    .WE(we),
    .wr(s_rx_done_tick),
    .w_data(s_dout),
    .address(address[4:2]),
    .r_data(readAux),

    .DEBUGBuffer0(DEBUGBuffer0),
    .DEBUGBuffer1(DEBUGBuffer1),
    .DEBUGBuffer2(DEBUGBuffer2),
    .DEBUGBuffer3(DEBUGBuffer3),
    .DEBUGBuffer4(DEBUGBuffer4),
    .DEBUGBuffer5(DEBUGBuffer5)
);

TBuffer tbuffer(
    .clk(clk),
    .wr(we),
    .rd(s_tx_done_tick),
    .w_data(writeDataAux),
    .address(address[5:2]),
    .r_data(s_din),
    .full(s_tx_start)
);

endmodule