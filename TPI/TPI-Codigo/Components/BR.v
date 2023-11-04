/*module contador (
   input wire clk,
   input reg[15:0] pcNext,
   output reg[15:0] pc
);*/
module BR(
    input wire clk,
    input [4:0] a1,
    input [4:0] a2,
    input [4:0] a3,
    input [31:0] wd3,
    input wire we,
    output [31:0] rd1,
    output [31:0] rd2
);

reg [31:0] regBank[31:0];
integer i;

initial begin
    for(i = 0;i<32;i=i+1) begin
        regBank[i] <= 32'h00000000;
    end
end

always @(posedge clk)
begin
    if(we)
    begin
        regBank[a3] <= wd3;
        //que escriba
    end
    //bla
end
<<<<<<< HEAD

always@(*)
    regBank[0] <= 0;

=======
>>>>>>> parent of b6ca6a3 (.)
assign rd1 = regBank[a1];
assign rd2 = regBank[a2];

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