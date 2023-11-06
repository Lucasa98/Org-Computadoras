`include "UARTComp/Receiver.v"
`include "UARTComp/Transmitter.v"
`include "UARTComp/FIFO.v"
`include "UARTComp/RateGenerator.v"

module UART(
    input wire clk,
    input wire Rx,
    input wire rd_uart,
    input [7:0] w_data,
    input wire wr_uart,
    output [7:0] r_data,
    output wire Rx_empty,
    output wire Tx_full,
    output wire Tx
);

//----------cableciños----------
wire s_tick;
wire[7:0] s_dout;
wire s_Rx_done_tick;
wire[7:0] s_din;
wire s_Tx_done_tick;
wire s_Tx_empty;
wire s_Tx_start;
//------------------------------


Receiver receiver(
    .clk(clk),
    .Rx(Rx),
    .dout(s_dout),
    .Rx_done_tick(s_Rx_done_tick)
);

Transmitter transmitter(
    .Tx(Tx),
    .din(s_din),
    .Tx_done_tick(s_Tx_done_tick),
    .Tx_start(s_Tx_start)
);

FIFO fifoR(
    .w_data(s_dout),
    .wr(s_Rx_done_tick),
    .r_data(r_data),
    .rd(rd_uart),
    .empty(Rx_empty)
);

FIFO fifoT(
    .r_data(s_din),
    .rd(s_Tx_done_tick),
    .empty(s_Tx_empty),
    .w_data(w_data),
    .wr(wr_uart)
);

assign s_Tx_start = ~s_Tx_empty;

endmodule