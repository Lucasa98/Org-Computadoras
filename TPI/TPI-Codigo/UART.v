`include "UARTComp/FIFO.v"
`include "UARTComp/Receiver.v"
`include "UARTComp/Transmitter.v"

module UART(
    input wire clk,
    input wire Rx,
    input wire rd,
    input [7:0] w_data,
    input wire wr,
    output [7:0] r_data,
    output wire rx_empty,
    output wire Tx
);

//----------cableciños----------
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
    .clk(clk),
    .Tx(Tx),
    .din(s_din),
    .tx_done_tick(s_tx_done_tick),
    .tx_start(s_tx_start)
);

FIFO fifoR(
    .wr(s_rx_done_tick),
    .rd(rd),
    .w_data(s_dout),
    .r_data(r_data),
    .full(full),
    .empty(empty)
);

FIFO fifoT(
    .wr(wr),
    .rd(s_tx_done_tick),
    .w_data(w_data),
    .r_data(s_din),
    .empty(s_tx_empty)
);

always @(*)
    r_tx_start <= ~s_tx_empty;

assign s_tx_start = r_tx_start;

endmodule