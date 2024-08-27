`default_nettype none
`define DUMPSTR(x) `"x.vcd`"
`timescale 1 ns / 1 ps
// timescale <time_unit> / <time_precision>

module Top_tb();

//-- Simulation time: 1us (10 * 100ns)
parameter DURATION = 100000;

//-- Clock signal. It is not used in this simulation
reg clk = 0;
always #0.5 clk = ~clk;

// UART ports
reg Rx;

//Salidas
wire Tx;

//-- Instantiate the unit to test
Top UUT (
    .clk(clk),
    .Rx(Rx),

    //Salidas
    .Tx(Tx)
);

initial begin
    //-- File were to store the simulation results
    $dumpfile(`DUMPSTR(`VCD_OUTPUT));
    $dumpvars(0, Top_tb);

    //Ticks cada 7800 ps
    //#1 son 1ns

    //Enviaremos 8'b00111000 = 8
    #2
    //start-bit
    Rx = 0;
    //Data
    #624
    Rx = 0;
    #624
    Rx = 0;
    #624
    Rx = 0;
    #624
    Rx = 1;
    #624
    Rx = 1;
    #624
    Rx = 1;
    #624
    Rx = 0;
    #624
    Rx = 0;
    //Stop-bit
    #624
    Rx = 1;

    //Enviaremos 8'b00110111 = 7
    #624
    //start-bit
    Rx = 0;
    //Data
    #624
    Rx = 1;
    #624
    Rx = 1;
    #624
    Rx = 1;
    #624
    Rx = 0;
    #624
    Rx = 1;
    #624
    Rx = 1;
    #624
    Rx = 0;
    #624
    Rx = 0;
    //Stop-bit
    #624
    Rx = 1;

    //Enviaremos 8'b00101010 = *
    #624
    //start-bit
    Rx = 0;
    //Data
    #624
    Rx = 0;
    #624
    Rx = 1;
    #624
    Rx = 0;
    #624
    Rx = 1;
    #624
    Rx = 0;
    #624
    Rx = 1;
    #624
    Rx = 0;
    #624
    Rx = 0;
    //Stop-bit
    #624
    Rx = 1;

    //Enviaremos 8'b00111001 = 9
    #624
    //start-bit
    Rx = 0;
    //Data
    #624
    Rx = 1;
    #624
    Rx = 0;
    #624
    Rx = 0;
    #624
    Rx = 1;
    #624
    Rx = 1;
    #624
    Rx = 1;
    #624
    Rx = 0;
    #624
    Rx = 0;
    //Stop-bit
    #624
    Rx = 1;

    //Enviaremos 8'b00110011 = 3
    #624
    //start-bit
    Rx = 0;
    //Data
    #624
    Rx = 1;
    #624
    Rx = 1;
    #624
    Rx = 0;
    #624
    Rx = 0;
    #624
    Rx = 1;
    #624
    Rx = 1;
    #624
    Rx = 0;
    #624
    Rx = 0;
    //Stop-bit
    #624
    Rx = 1;

    #(DURATION) $display("End of simulation");
    $finish;
end

endmodule