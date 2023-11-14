`default_nettype none
`define DUMPSTR(x) `"x.vcd`"
`timescale 100 ns / 10 ns
// timescale <time_unit> / <time_precision>

module PC_tb();

//-- Simulation time: 1us (10 * 100ns)
parameter DURATION = 10;

//-- Clock signal. It is not used in this simulation
reg clk = 0;
always #0.5 clk = ~clk;

// contador ports
reg[15:0] pcNext;
wire[15:0] pc;

//-- Instantiate the unit to test
PC UUT (
  .clk(clk),
  .pcNext(pcNext),
  .pc(pc)
);

integer i;

initial begin

  //-- File were to store the simulation results
  $dumpfile(`DUMPSTR(`VCD_OUTPUT));
  $dumpvars(0, PC_tb);

  for (i=0; i<100; i=i+1)
  begin
    $display ("Current loop # %0d", i);
    $display ("Current loop # %0b", i);
    
    #0
    pcNext = 4'b0000;

    #1
    pcNext = 4'b0100;

    #2
    pcNext = 4'b1000;
  end

   #(DURATION) $display("End of simulation");
  $finish;
end

endmodule