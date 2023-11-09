module RBuffer(
    input clk,
    input wire wr,            //señal de escritura
    input [7:0] w_data,       //dato de escritura
    input [2:0] address,      //Dirección de lectura
    output reg [7:0] r_data,  //dato de lectura
    output wire full,         //bandera de llena

    output reg[7:0] DEBUGbank0,
    output reg[7:0] DEBUGbank1,
    output reg[7:0] DEBUGbank2,
    output reg[7:0] DEBUGbank3,
    output reg[7:0] DEBUGbank4
);

//punteros de escritura y lectura
reg [2:0] w_ptr;
reg [7:0] buffer[5];
reg aux_full;

// Valores por defecto
initial
begin
    w_ptr <= 0;
    r_data <= 0;
    aux_full <= 0;
end

// Escritura
always@(posedge clk)
begin
    if(wr)
    begin
        aux_full <= 0;
        buffer[w_ptr] <= w_data;
        w_ptr <= w_ptr + 1;
        if(w_ptr > 4)
        begin
            aux_full <= 1;
            w_ptr <= 0;
        end
    end
end

// Lectura
always@(*)
begin
    r_data <= buffer[address];
    DEBUGbank0 <= buffer[0];
    DEBUGbank1 <= buffer[1];
    DEBUGbank2 <= buffer[2];
    DEBUGbank3 <= buffer[3];
    DEBUGbank3 <= buffer[4];
end

assign full = aux_full;
endmodule