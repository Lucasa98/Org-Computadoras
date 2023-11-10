`default_nettype none
`define DUMPSTR(x) `"x.vcd`"
`timescale 1 ns / 1 ps
// timescale <time_unit> / <time_precision>

module Top_tb();

//-- Simulation time: 1us (10 * 100ns)
parameter DURATION = 100000;

//-- Clock signal. It is not used in this simulation
reg clk = 0;
always #0.1 clk = ~clk;

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

    //Enviaremos 8'b00111000 = 56
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
    Rx = 1;
    #8
    Rx = 1;
    #8
    Rx = 0;
    #8
    Rx = 0;
    //Stop-bit
    #8
    Rx = 1;

    //Enviaremos 8'b00110111 = 7
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
    Rx = 1;
    #8
    Rx = 1;
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

    //Enviaremos 8'b00111001 = 9
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
    Rx = 1;
    #8
    Rx = 1;
    #8
    Rx = 0;
    #8
    Rx = 0;
    //Stop-bit
    #8
    Rx = 1;

    //Enviaremos 8'b00110011 = 3
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
    Rx = 1;
    #8
    Rx = 1;
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