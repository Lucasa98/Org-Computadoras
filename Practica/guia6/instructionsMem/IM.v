/*module contador (
   input wire clk,
   input reg[15:0] pcNext,
   output reg[15:0] pc
);*/
module IM(
    //input wire clk,
    input [4:0] addres,
    output [31:0] rd
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

assign rd = ROM[addres];

endmodule
//Banco de registros
//Con a1 defino el operando 1
//imm[11:0]|rs1|funct3|rd(registro destino)|opcode
//funct7|rs2|rs1|funct3|rd|opcode
//rs2 es a2, rs1 es a1, rd es a3
//A la alu le tengo que agregar una senial
//de control que me permita ver que operacion
//realiza. Entre estas tiene que estar set less than
//suma, resta por complemento a 2, and y or
////////
//Voy a construir un procesador monociclo, es 
//directamente un circuito combinacional
//en las diapositivas para hacer el datapath
//deja las memorias por un lado y la parte logica 
//por otro