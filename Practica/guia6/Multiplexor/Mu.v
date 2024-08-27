module Mu(
    input [31:0] e1,
    input [31:0] e2,
    input wire sel,
    output [31:0] sal
);
reg [31:0] aux;
always@()
    begin
        case(sel)
            begin
            1'b0:
                aux = e1;
            1'b1:
                aux = e2;
            end
    end
assign sal <= aux;

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
//por otro: