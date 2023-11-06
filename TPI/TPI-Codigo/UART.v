`include "UARTComps/Receiver.v"
`include "UARTComps/Transmitter.v"
`include "UARTComps/FIFO.v"
`include "UARTComps/RateGenerator.v"

module UART(
    input wire clk,
    input wire rx,
    input wire rd_uart,
    input wire w_data,
    input wire wr_uart,
    output wire r_data,
    output wire rx_empty,
    output wire tx_full,
    output wire tx
);

//----------cableciños----------
wire s_tick;
wire s_dout;
wire s_rx_done_tick;
wire s_din;
wire s_tx_done_tick;
wire s_tx_start;
//------------------------------

RateGenerator generator(
    .clk(clk),
    .tick(tick)
);

Receiver receiver(
    .clk(clk),
    .rx(rx),
    .s_tick(s_tick),
    .dout(s_dout),
    .rx_done_tick(s_rx_done_tick)
);

Transmitter transmitter(
    .tx(tx),
    .s_tick(s_tick),
    .din(s_din),
    .tx_done_tick(s_tx_done_tick),
    .tx_start(not s_tx_start)
);

FIFO fifoR(
    .w_data(s_dout),
    .wr(s_rx_done_tick),
    .full(no se),
    .r_data(r_data),
    .rd(rd_uart),
    .rx_empty(rx_empty)
);

FIFO fifoT(
    .r_data(s_din),
    .rd(s_tx_done_tick),
    .rx_empty(s_tx_start),
    .w_data(w_data),
    .wr(wr_uart),
    .full(tx_full)
);

endmodule