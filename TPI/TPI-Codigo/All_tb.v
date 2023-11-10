`default_nettype none
`define DUMPSTR(x) `"x.vcd`"
`timescale 1 ns / 1 ps
// timescale <time_unit> / <time_precision>

module UART_tb();

//-- Simulation time: 1us (10 * 100ns)
parameter DURATION = 100000;

//-- Clock signal. It is not used in this simulation
reg clk = 0;
always #0.1 clk = ~clk;

// UART ports
reg Rx;
reg[2:0] address;
reg[7:0] w_data;
reg we;
wire[7:0] r_data;
wire Tx;

//-- Instantiate the unit to test
UART UUT (
    .clk(clk),
    .Rx(Rx),
    .address(address),
    .w_data(w_data),
    .we(we),
    .r_data(r_data),
    .Tx(Tx)
);

initial begin
    //-- File were to store the simulation results
    $dumpfile(`DUMPSTR(`VCD_OUTPUT));
    $dumpvars(0, UART_tb);

    //Enviaremos 8'b00001000 = 8
    #2
    //start-bit
    Rx = 0;
    //Data
    #8
    Rx = 0;
    #8
    Rx = 0;
    #8
    Rx = 0;
    #8
    Rx = 1;
    #8
    Rx = 0;
    #8
    Rx = 0;
    #8
    Rx = 0;
    #8
    Rx = 0;
    //Stop-bit
    #8
    Rx = 1;

    //Enviaremos 8'b00000111 = 7
    #8
    //start-bit
    Rx = 0;
    //Data
    #8
    Rx = 1;
    #8
    Rx = 1;
    #8
    Rx = 1;
    #8
    Rx = 0;
    #8
    Rx = 0;
    #8
    Rx = 0;
    #8
    Rx = 0;
    #8
    Rx = 0;
    //Stop-bit
    #8
    Rx = 1;

    //Enviaremos 8'b00101010 = *
    #8
    //start-bit
    Rx = 0;
    //Data
    #8
    Rx = 0;
    #8
    Rx = 1;
    #8
    Rx = 0;
    #8
    Rx = 1;
    #8
    Rx = 0;
    #8
    Rx = 1;
    #8
    Rx = 0;
    #8
    Rx = 0;
    //Stop-bit
    #8
    Rx = 1;

    //Enviaremos 8'b00001001 = 9
    #8
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
    Rx = 0;
    #8
    Rx = 0;
    #8
    Rx = 0;
    #8
    Rx = 0;
    //Stop-bit
    #8
    Rx = 1;

    //Enviaremos 8'b00000011 = 3
    #8
    //start-bit
    Rx = 0;
    //Data
    #8
    Rx = 1;
    #8
    Rx = 1;
    #8
    Rx = 0;
    #8
    Rx = 0;
    #8
    Rx = 0;
    #8
    Rx = 0;
    #8
    Rx = 0;
    #8
    Rx = 0;
    //Stop-bit
    #8
    Rx = 1;

    #(DURATION) $display("End of simulation");
    $finish;
end

endmodule