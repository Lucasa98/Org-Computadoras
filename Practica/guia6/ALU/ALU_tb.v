//-------------------------------------------------------------------
//-- g02_e09_tb.v
//-- Testbench
//-------------------------------------------------------------------
//-- Guido Sanchez
//-- GPL license
//-------------------------------------------------------------------

`default_nettype none
`define DUMPSTR(x) `"x.vcd`"
`timescale 100 ns / 10 ns
// timescale <time_unit> / <time_precision>

module BR_tb();

//-- Simulation time: 1us (10 * 100ns)
parameter DURATION = 10;

//-- Clock signal. It is not used in this simulation
reg clk = 0;
always #0.5 clk = ~clk;

// contador ports
reg[4:0] a1;
reg[4:0] a2;
reg[4:0] a3;
reg[31:0] wd3;

wire we;

reg[31:0] rd1;
reg[31:0] rd2;

//-- Instantiate the unit to test
BR UUT (
          .clk(clk),
          .a1(a1),
          .a2(a2),
          .a3(a3),
          .wd3(wd3),
          .we(we),
          .rd1(rd1),
          .rd2(rd2),
          .pc(pc)
         );

integer i;

initial begin

  //-- File were to store the simulation results
  $dumpfile(`DUMPSTR(`VCD_OUTPUT));
  $dumpvars(0, BR_tb);

  for (i=0; i<100; i=i+1)
  begin
    $display ("Current loop # %0d", i);
    $display ("Current loop # %0b", i);
    
    #0
    pcNext = 16'h0;

  end

   #(DURATION) $display("End of simulation");
  $finish;
end

endmodule