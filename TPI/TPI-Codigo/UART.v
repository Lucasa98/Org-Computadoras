`include "UARTComp/RBuffer.v"
`include "UARTComp/TBuffer.v"
`include "UARTComp/Receiver.v"
`include "UARTComp/Transmitter.v"
`include "UARTComp/Converter.v"

module UART(
    input wire clk,
    input wire i_Rx,
    input [15:0] address,
    input [31:0] w_data,
    input wire we,
    output [31:0] r_data,
    output wire o_Tx
);

//----------cableciños----------
wire[7:0] s_dout;
wire s_rx_done_tick;
wire[7:0] s_din;
wire s_tx_done_tick;
wire s_tx_start;

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

Receiver receiver(
    .clk(clk),
    .i_Rx(i_Rx),
    .Rx_done_tick(s_rx_done_tick),
    .dout(s_dout)
);

Transmitter transmitter(
    .clk(clk),
    .o_Tx(o_Tx),
    .din(s_din),
    .tx_done_tick(s_tx_done_tick),
    .tx_start(s_tx_start)
);

RBuffer rbuffer(
    .clk(clk),
    .wr(s_rx_done_tick),
    .w_data(s_dout),
    .address(address[2:0]),
    .r_data(readAux)
);

TBuffer tbuffer(
    .clk(clk),
    .wr(we),
    .rd(s_tx_done_tick),
    .w_data(writeDataAux),
    .address(address[2:0]),
    .r_data(s_din),
    .full(s_tx_start)
);

endmodule