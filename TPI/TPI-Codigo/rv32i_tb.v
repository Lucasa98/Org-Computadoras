`default_nettype none
`define DUMPSTR(x) `"x.vcd`"
`timescale 100 ns / 10 ns
// timescale <time_unit> / <time_precision>

module rv32i_tb();

//-- Simulation time: 1us (10 * 100ns)
parameter DURATION = 10;

//-- Clock signal. It is not used in this simulation
reg clk = 0;
always #0.5 clk = ~clk;

// rv32i ports
reg[31:0] instr;
reg[31:0] readData;

wire[15:0] pc;
wire WE;
wire[15:0] address;
wire[31:0] writeData;

//-- Instantiate the unit to test
rv32i UUT (
    //Entradas
    .clk(clk),
    .instr(instr),
    .readData(readData),

    //Salidas
    .pc(pc),
    .WE(WE),
    .address(address),
    .writeData(writeData)
);

initial begin
  //-- File were to store the simulation results
  $dumpfile(`DUMPSTR(`VCD_OUTPUT));
  $dumpvars(0, rv32i_tb);

  // Queremos implementar la instruccion
  // addi x8,x0,3
  // addi x8,x8,3
  #0
  // addi x8,x0,3
  //imm[31:20] = 3
  //rs1[19:15] = 00000
  //funct3[14:12] = 0
  //rd[11:7] = 01000
  //opcode[6:0] = 0010011
  instr = 32'b00000000001100000000010000010011;
  #1
  //nop
  instr = 32'b00000000000000000000000000010011;
  #1
  //addi x8,x8,3
  instr = 32'b00000000001101000000010000010011;
  #1
  //nop
  instr = 32'b00000000000000000000000000010011;
  #1
  //addi x8,x8,2
  instr = 32'b00000000001001000000010000010011;
  #1
  //nop
  instr = 32'b00000000000000000000000000010011;
  #1
  //addi x8,x8,2
  instr = 32'b00000000000001000000010000010011;


  #(DURATION) $display("End of simulation");
  $finish;
end

endmodule