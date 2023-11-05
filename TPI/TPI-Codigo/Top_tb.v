`default_nettype none
`define DUMPSTR(x) `"x.vcd`"
`timescale 100 ns / 10 ns
// timescale <time_unit> / <time_precision>

module Top_tb();

//-- Simulation time: 1us (10 * 100ns)
parameter DURATION = 10;

//-- Clock signal. It is not used in this simulation
reg clk = 0;
always #0.5 clk = ~clk;

// Top ports
wire[31:0] sal;
wire[15:0] addressSal;

//-- Instantiate the unit to test
Top UUT (
    .clk(clk),
    .sal(sal),
    .addressSal(addressSal)
);

initial begin

  //-- File were to store the simulation results
  $dumpfile(`DUMPSTR(`VCD_OUTPUT));
  $dumpvars(0, Top_tb);
    
    //Se ejecuta el programa cargado en IM

   #(DURATION) $display("End of simulation");
  $finish;
end

endmodule