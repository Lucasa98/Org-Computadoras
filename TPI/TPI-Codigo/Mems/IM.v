module IM(
    //input wire clk,
    input [15:0] pc,
    output [31:0] instr
);
//hay que hardcodear todas las innstrucciones xddddddd

parameter ROM_WIDTH = 32;
parameter ROM_ADDR_BITS = 8;
(* ROM_STYLE="{AUTO |DISTRIBUTED |BLOCK}" *)
reg [ROM_WIDTH-1:0] ROM [(2**ROM_ADDR_BITS)-1:0];

initial begin
    ROM[0] = 32'h000085B7;	//direccion de la uart
    ROM[1] = 
    ROM[4] = 32'h0145a803;
    ROM[8] = 32'hfe080ee3;
    ROM[12] = 32'h0005a603;
    ROM[16] = 32'h0045a683;
    ROM[20] = 32'h00c5a703;
    ROM[24] = 32'h0105a783;
    ROM[28] = 32'hfd060613;
    ROM[32] = 32'hfd068693;
    ROM[36] = 32'hfd070713;
    ROM[40] = 32'hfd078793;
    ROM[44] = 32'h00060293;
    ROM[48] = 32'h00070313;
    ROM[52] = 32'h00900393;
    ROM[56] = 32'h00038a63;
    ROM[60] = 32'h00560633;
    ROM[64] = 32'h00670733;
    ROM[68] = 32'hfff38393;
    ROM[72] = 32'hff1ff0ef;
    ROM[76] = 32'h00d60633;
    ROM[80] = 32'h00f70733;
    ROM[84] = 32'h00c002b3;
    ROM[88] = 32'hfff70713;
    ROM[92] = 32'h00070863;
    ROM[96] = 32'h00560633;
    ROM[100] = 32'hfff70713;
    ROM[104] = 32'hff5ff0ef;
    ROM[108] = 32'h00a00393;
    ROM[112] = 32'h00060ab3;
    ROM[116] = 32'h00000b13;
    ROM[120] = 32'h007ac863;
    ROM[124] = 32'h407a8ab3;
    ROM[128] = 32'h001b0b13;
    ROM[132] = 32'hff5ff0ef;
    ROM[136] = 32'h00000b93;
    ROM[140] = 32'h007b4863;
    ROM[144] = 32'h407b0b33;
    ROM[148] = 32'h001b8b93;
    ROM[152] = 32'hff5ff0ef;
    ROM[156] = 32'h00000c13;
    ROM[160] = 32'h007bc863;
    ROM[164] = 32'h407b8bb3;
    ROM[168] = 32'h001c0c13;
    ROM[172] = 32'hff5ff0ef;
    ROM[176] = 32'h0155ac23;
    ROM[180] = 32'h0165ae23;
    ROM[184] = 32'h0375a023;
    ROM[188] = 32'h0385a223;
    ROM[192] = 32'hf45ff0ef;
end

assign instr = ROM[pc];

endmodule