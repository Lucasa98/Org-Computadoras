`default_nettype none
`define DUMPSTR(x) `"x.vcd`"
`timescale 10 ns / 1 ns
// timescale <time_unit> / <time_precision>

module Top_tb();

//-- Simulation time: 1us (10 * 100ns)
parameter DURATION = 100;

//-- Clock signal. It is not used in this simulation
reg clk = 0;
always #0.1 clk = ~clk;

// Top ports
//Salidas
wire rx;
wire tx;

//-- Instantiate the unit to test
Top UUT (
    .clk(clk),
    .Rx(rx),

    //Salidas
    .Tx(tx)
);

initial begin
    //-- File were to store the simulation results
    $dumpfile(`DUMPSTR(`VCD_OUTPUT));
    $dumpvars(0, Top_tb);

     //Enviaremos 8'b00110101 = 5
    #2
    //start-bit
    Rx = 0;
    //Data
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
    Rx = 1;
    #8
    Rx = 0;
    #8
    Rx = 0;
    //Stop-bit
    #8
    Rx = 1;

    //Enviaremos 8'b00110110 = 6
    #8
    //start-bit
    Rx = 0;
    //Data
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

    //Enviaremos 8'b00110001 = 1
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