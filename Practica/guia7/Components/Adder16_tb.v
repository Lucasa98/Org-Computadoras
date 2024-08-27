`default_nettype none
`define DUMPSTR(x) `"x.vcd`"
`timescale 100 ns / 10 ns
// timescale <time_unit> / <time_precision>

module Adder16_tb();

//-- Simulation time: 1us (10 * 100ns)
parameter DURATION = 10;

//-- Clock signal. It is not used in this simulation
reg clk = 0;
always #0.5 clk = ~clk;

// contador ports
reg[15:0] op1;
reg[15:0] op2;
wire[15:0] res;

//-- Instantiate the unit to test
Adder16 UUT (
  .op1(op1),
  .op2(op2),
  .res(res)
);

integer i;

initial begin

  //-- File were to store the simulation results
  $dumpfile(`DUMPSTR(`VCD_OUTPUT));
  $dumpvars(0, Adder16_tb);

  for (i=0; i<100; i=i+1)
  begin
    $display ("Current loop # %0d", i);
    $display ("Current loop # %0b", i);
    
    #0
    op1 = 0;
    op2 = 4;

    #10
    op1 = 4;
    op2 = 4;

    #10
    op1 = 4;
    op2 = 8;

  end

   #(DURATION) $display("End of simulation");
  $finish;
end

endmodule