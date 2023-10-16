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
    //ROM[0] = 32'h00300413;
    //ROM[1] = 32'h00100493;
    //...
end

assign instr = ROM[pc];

endmodule