`include "UARTComp/FIFO.v"
`include "UARTComp/Receiver.v"
`include "UARTComp/Transmitter.v"

module UART(
    input wire clk,
    input wire Rx,
    input wire rd_uart,
    input [7:0] w_data,
    input wire wr_uart,
    output [7:0] r_data,
    output wire rx_empty,
    output wire Tx
);

//----------cableciños----------
wire s_tick;
wire[7:0] s_dout;
wire s_rx_done_tick;
wire[7:0] s_din;
wire s_tx_done_tick;
wire s_tx_empty;
wire s_tx_start;
//------------------------------

reg r_tx_start;

Receiver receiver(
    .clk(clk),
    .Rx(Rx),
    .Rx_done_tick(s_rx_done_tick),
    .dout(s_dout)
);

Transmitter transmitter(
    .Tx(Tx),
    .din(s_din),
    .tx_done_tick(s_tx_done_tick),
    .tx_start(s_tx_start)
);

FIFO fifoR(
    .w_data(s_dout),
    .wr(s_rx_done_tick),
    .r_data(r_data),
    .rd(rd_uart),
    .empty(rx_empty)
);

FIFO fifoT(
    .r_data(s_din),
    .rd(s_tx_done_tick),
    .empty(s_tx_empty),
    .w_data(w_data),
    .wr(wr_uart)
);

always @(*)
    r_tx_start <= ~s_tx_empty;

assign s_tx_start = r_tx_start;

endmodule