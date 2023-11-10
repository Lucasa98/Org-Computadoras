`include "UARTComp/RBuffer.v"
`include "UARTComp/TBuffer.v"
`include "UARTComp/Receiver.v"
`include "UARTComp/Transmitter.v"
`include "UARTComp/Converter.v"

module UART(
    input wire clk,
    input wire Rx,
    input [2:0] address,
    input [7:0] w_data,
    input wire we,
    output [7:0] r_data,
    output wire rx_empty,
    output wire Tx,
    output wire full
);

//----------cableciños----------
wire[7:0] s_dout;
wire s_rx_done_tick;
wire[7:0] s_din;
wire s_tx_done_tick;
wire s_tx_start;

wire[7:0] DEBUGbuffer0;
wire[7:0] DEBUGbuffer1;
wire[7:0] DEBUGbuffer2;
wire[7:0] DEBUGbuffer3;
//------------------------------

Receiver receiver(
    .clk(clk),
    .Rx(Rx),
    .Rx_done_tick(s_rx_done_tick),
    .dout(s_dout)
);

Transmitter transmitter(
    .clk(clk),
    .Tx(Tx),
    .din(s_din),
    .tx_done_tick(s_tx_done_tick),
    .tx_start(s_tx_start)
);

RBuffer rbuffer(
    .clk(clk),
    .wr(s_rx_done_tick),
    .w_data(s_dout),
    .address(address),
    .r_data(r_data),
    .full(full)
);

TBuffer tbuffer(
    .clk(clk),
    .wr(we),
    .rd(s_tx_done_tick),
    .w_data(w_data),
    .address(address),
    .r_data(s_din),
    .full(s_tx_start),

    .DEBUGbuffer0(DEBUGbuffer0),
    .DEBUGbuffer1(DEBUGbuffer1),
    .DEBUGbuffer2(DEBUGbuffer2),
    .DEBUGbuffer3(DEBUGbuffer3)
);

endmodule