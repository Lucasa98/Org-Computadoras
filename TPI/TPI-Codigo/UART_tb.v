`default_nettype none
`define DUMPSTR(x) `"x.vcd`"
`timescale 10 ns / 1 ns
// timescale <time_unit> / <time_precision>

module UART_tb();

//-- Simulation time: 1us (10 * 100ns)
parameter DURATION = 10000;

//-- Clock signal. It is not used in this simulation
reg clk = 0;
always #0.1 clk = ~clk;

// Top ports
reg Rx=1;
reg rd_uart;
reg[7:0] w_data;
reg wr_uart;
wire[7:0] r_data;
wire rx_empty;
wire Tx;

//-- Instantiate the unit to test
UART UUT (
    .clk(clk),
    .Rx(Rx),
    .rd_uart(rd_uart),
    .w_data(w_data),
    .wr_uart(wr_uart),
    .r_data(r_data),
    .rx_empty(rx_empty),
    .Tx(Tx)
);

initial begin
    //-- File were to store the simulation results
    $dumpfile(`DUMPSTR(`VCD_OUTPUT));
    $dumpvars(0, UART_tb);

    //Enviaremos 8'b10011010
    #2
    //start-bit
    Rx = 0;
    //Data
    #8
    Rx = 1;
    #8
    Rx = 0;
    #8
    Rx = 0;
    #8
    Rx = 1;
    #8
    Rx = 1;
    #8
    Rx = 0;
    #8
    Rx = 1;
    #8
    Rx = 0;
    //Stop-bit
    #8
    Rx = 1;

    #(DURATION) $display("End of simulation");
    $finish;
end

endmodule