module IM(
    //input wire clk,
    input [15:0] pc,
    output [31:0] instr
);
//hay que hardcodear todas las innstrucciones xddddddd

parameter ROM_WIDTH = 32;
parameter ROM_ADDR_BITS = 5;
(* ROM_STYLE="{AUTO |DISTRIBUTED |BLOCK}" *)
reg [ROM_WIDTH-1:0] ROM [(2**ROM_ADDR_BITS)-1:0];

initial begin
<<<<<<< Updated upstream
   ROM[0] = 32'h100105b7
   ROM[1] = 32'h0005a283
   ROM[2] = 32'h00a00313
   ROM[3] = 32'hfd028293
   ROM[4] = 32'h00100393
   ROM[5] = 32'h00500eb3
   ROM[6] = 32'h00638863
   ROM[7] = 32'h01d282b3
   ROM[8] = 32'h00138393
   ROM[9] = 32'hff5ff06f
   ROM[10] = 32'h00458593
   ROM[11] = 32'h0005ae03
   ROM[12] = 32'hfd0e0e13
   ROM[13] = 32'h01c284b3
   ROM[14] = 32'h00858593
   ROM[15] = 32'h0005a283
   ROM[16] = 32'h00a00313
   ROM[17] = 32'hfd028293
   ROM[18] = 32'h00100393
   ROM[19] = 32'h00500eb3
   ROM[20] = 32'h00638863
   ROM[21] = 32'h01d282b3
   ROM[22] = 32'h00138393
   ROM[23] = 32'hff5ff06f
   ROM[24] = 32'h00458593
   ROM[25] = 32'h0005ae03
   ROM[26] = 32'hfd0e0e13
   ROM[27] = 32'h01c28933
   ROM[28] = 32'h00100393
   ROM[29] = 32'h00900eb3
   ROM[30] = 32'h01238863
   ROM[31] = 32'h01d484b3
   ROM[32] = 32'h00138393
   ROM[33] = 32'hff5ff06f
    /* // LAS INSTRUCCIONES:
=======
    // LAS INSTRUCCIONES:
>>>>>>> Stashed changes
    // addi x8,x0,3
    //imm[31:20] = 3
    //rs1[19:15] = 00000
    //funct3[14:12] = 0
    //rd[11:7] = 01000
    //opcode[6:0] = 0010011
    ROM[0] = 32'b00000000001100000000010000010011;
    //addi x0,x0,0  (nop)
    ROM[4] = 32'b00000000000000000000000000010011;
    //addi x8,x8,3
    ROM[8] = 32'b00000000001101000000010000010011;
    //addi x0,x0,0  (nop)
    ROM[12] = 32'b00000000000000000000000000010011;
    //addi x8,x8,2
    ROM[16] = 32'b00000000001001000000010000010011;
    //addi x0,x0,0  (nop)
    ROM[20] = 32'b00000000000000000000000000010011;
    //addi x8,x8,2
    ROM[24] = 32'b00000000000001000000010000010011;
    //...
end

assign instr = ROM[pc];

endmodule