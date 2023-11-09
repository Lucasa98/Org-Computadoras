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
   /* ROM[0] = 32'h00000293;
   ROM[1] = 32'h00000393;
   ROM[2] = 32'h00100313;
   ROM[3] = 32'h100105b7;
   ROM[4] = 32'h0005ae03;
   ROM[5] = 32'hfd0e0e13;
   ROM[6] = 32'h00a00e93;
   ROM[7] = 32'h00100f13;
   ROM[8] = 32'h01c00fb3;
   ROM[9] = 32'h01df0863;
   ROM[10] = 32'h01fe0e33;
   ROM[11] = 32'h001f0f13;
   ROM[12] = 32'hff5ff06f;
   ROM[13] = 32'h02628e63;
   ROM[14] = 32'h00458593;
   ROM[15] = 32'h0005ae83;
   ROM[16] = 32'hfd0e8e93;
   ROM[17] = 32'h00638a63;
   ROM[18] = 32'h01ce84b3;
   ROM[19] = 32'h00858593;
   ROM[20] = 32'h00138393;
   ROM[21] = 32'hfbdff06f;
   ROM[22] = 32'h01ce8933;
   ROM[23] = 32'h00900e33;
   ROM[24] = 32'h00900fb3;
   ROM[25] = 32'h00100f13;
   ROM[26] = 32'h00128293;
   ROM[27] = 32'hfb9ff06f; */
   ROM[0] = 32'h00c00513;
   ROM[4] = 32'h00900593;
   ROM[8] = 32'h40b50633;
end

assign instr = ROM[pc];

endmodule