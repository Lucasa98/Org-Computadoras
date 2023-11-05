module IM(
    //input wire clk,
    input [15:0] pc,
    output [31:0] instr,
    output [31:0] DEBUGinstr16,
    output [31:0] DEBUGinstr20
);
//hay que hardcodear todas las innstrucciones xddddddd

parameter ROM_WIDTH = 32;
parameter ROM_ADDR_BITS = 5;
(* ROM_STYLE="{AUTO |DISTRIBUTED |BLOCK}" *)
reg [ROM_WIDTH-1:0] ROM [(2**ROM_ADDR_BITS)-1:0];

initial begin
    // LAS INSTRUCCIONES:

    //imm[31:20] = 3
    //rs1[19:15] = 00000
    //funct3[14:12] = 0
    //rd[11:7] = 01000
    //opcode[6:0] = 0010011
    //inicio: addi x8,x0,3
    ROM[0] = 32'h00300413;
    //addi x8,x8,3
    ROM[4] = 32'h00340413;
    //addi x8,x8,2
    ROM[8] = 32'h00240413;
    //addi x8,x8,2
    ROM[12] = 32'h00240413;
    //idle: beq x31,x0,inicio
    ROM[16] = 32'hfe0f88e3;
    //nop
    ROM[20] = 32'h00000013;
    //jal idle
    ROM[24] = 32'hff9ff0ef;
end

assign instr = ROM[pc];
assign DEBUGinstr16 = ROM[16];
assign DEBUGinstr20 = ROM[20];

endmodule