module ALU(
    input [31:0] srcA,
    input [31:0] srcB,
    input [2:0] ALUControl,
    output [31:0] res
);

reg [31:0] aux;
always @()
begin
    case (ALUControl)
    begin
        3'b000:
            aux = srcA+srcB;
        3'b001:
            aux = srcA-srcB;
        3'b010:
            aux = srcA and srcB;
        3'b011:
            aux = srcA or srcB
        3'b101:
            //SLT :)
        default:
            aux = srcA;
    end
end
assign res <= aux;
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