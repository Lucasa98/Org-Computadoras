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
    // LAS INSTRUCCIONES:
    // addi x8,x0,3
    //imm[31:20] = 3
    //rs1[19:15] = 00000
    //funct3[14:12] = 0
    //rd[11:7] = 01000
    //opcode[6:0] = 0010011
    ROM[0] = 32'b00000000001100000000010000010011;
    //addi x8,x8,3
    ROM[4] = 32'b00000000001101000000010000010011;
    //addi x8,x8,2
    ROM[8] = 32'b00000000001001000000010000010011;
    //addi x8,x8,2
    ROM[12] = 32'b00000000000001000000010000010011;
    //...
end

assign instr = ROM[pc];

endmodule