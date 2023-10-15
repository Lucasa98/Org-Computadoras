module DM(
    input wire clk,
    input [15:0] addres,
    input [31:0] wd,
    input wire we,
    output [31:0] rd
);

reg [31:0] dataBank[31:0];
integer i;

always @(posedge rst)
begin
    for(i = 0;i<32;i=i+1) begin
        bank[i] <= 32'h00000000;
    end
end

always @(posedge clk)
begin
    if(we)
    begin
        dataBank[addres] <= wd;
        //que escriba
    end
    //bla
end
assign rd = dataBank[a1];

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