`default_nettype none
`define DUMPSTR(x) `"x.vcd`"
`timescale 100 ns / 10 ns
// timescale <time_unit> / <time_precision>

module dataPath_tb();

//-- Simulation time: 1us (10 * 100ns)
parameter DURATION = 10;

//-- Clock signal. It is not used in this simulation
reg clk = 0;
always #0.5 clk = ~clk;

// contador ports
reg[31:0] instr;     //de la memoria
reg[31:0] readData;  //de la memoria
reg pcSrc;       //de la UC
reg resSrc;      //de la UC  (para el jal necesita 2 bits)
    //input wire memWrite,  //de la UC  ---En realidad va directo a la memoria---
reg[2:0] ALUControl; //de la UC
reg ALUSrc;      //de la UC
reg[1:0] inmSrc;     //de la UC
reg regWrite;    //de la UC
    //Salidas
wire[15:0] pc;       //a la memoria
wire[15:0] address;  //a la memoria
wire[31:0] writeData;//a la memoria
wire zero;       //a la UC
wire f7;         //a la UC
wire[2:0] f3;        //a la UC
wire[6:0] op;         //a la UC

//-- Instantiate the unit to test
dataPath UUT (
          .clk(clk),
          .instr(instr),
          .readData(readData),
          .pcSrc(pcSrc),
          .resSrc(resSrc),
          .ALUControl(ALUControl),
          .ALUSrc(ALUSrc),
          .inmSrc(inmSrc),
          .regWrite(regWrite),
          .pc(pc),  //output    
          .address(address),  
          .writeData(writeData),
          .zero(zero),
          .f7(f7),
          .f3(f7),
          .op(op)
         );

integer i;

initial begin

  //-- File were to store the simulation results
  $dumpfile(`DUMPSTR(`VCD_OUTPUT));
  $dumpvars(0, dataPath_tb);
    
    // Queremos implementar la instruccion
    // addi x8,x0,3
    // addi x8,x8,3

    #0
    //imm[31:20] = 3
    //rs1[19:15] = 00000
    //funct3[14:12] = 0
    //rd[11:7] = 01000
    //opcode[6:0] = 0010011
    instr = 32'b00000000001100000000010000010011;
    pcSrc = 0;      //no hay salto
    resSrc = 1;     //viene de la alu
    ALUControl = 0; //suma
    ALUSrc = 1;     //toma el inm
    inmSrc = 0;     //tipo I
    regWrite = 1;   //escribe en el BR

    #2
    //addi x8,x8,3
    instr = 32'b00000000001101000000010000010011;
    pcSrc = 0;      //no hay salto
    resSrc = 1;     //viene de la alu
    ALUControl = 0; //suma
    ALUSrc = 1;     //toma el inm
    inmSrc = 0;     //tipo I
    regWrite = 1;   //escribe en el BR

    #2
    //addi x8,x8,2
    instr = 32'b00000000001001000000010000010011;
    pcSrc = 0;      //no hay salto
    resSrc = 1;     //viene de la alu
    ALUControl = 0; //suma
    ALUSrc = 1;     //toma el inm
    inmSrc = 0;     //tipo I
    regWrite = 1;   //escribe en el BR

     #2
    //addi x8,x8,2
    instr = 32'b00000000000001000000010000010011;
    pcSrc = 0;      //no hay salto
    resSrc = 1;     //viene de la alu
    ALUControl = 0; //suma
    ALUSrc = 1;     //toma el inm
    inmSrc = 0;     //tipo I
    regWrite = 1;   //escribe en el BR

   #(DURATION) $display("End of simulation");
  $finish;
end

endmodule