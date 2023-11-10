module TBuffer(
    input wire clk,
    input wire wr,            //señal de escritura
    input wire rd,            //señal de lectura ("borra" el registro leido)
    input [7:0] w_data,       //dato de escritura
    input [2:0] address,      //Dirección de escritura
    output reg [7:0] r_data,  //dato de lectura
    output wire full,         //bandera de llena

    output reg[7:0] DEBUGbuffer0,
    output reg[7:0] DEBUGbuffer1,
    output reg[7:0] DEBUGbuffer2,
    output reg[7:0] DEBUGbuffer3
);

//punteros de escritura y lectura
reg [2:0] r_ptr;
reg [2:0] count_w;  //contador de escrituras
reg [7:0] buffer[4];
reg aux_full;

// Valores por defecto
initial
begin
    count_w <= 0;
    r_ptr <= 0;
    r_data <= 0;
    aux_full <= 0;
end

// Escritura
always@(posedge rd)
begin
    if(rd & full)      //si el transmitter leyo un dato, avanzamos el puntero de lectura
    begin
        r_ptr = r_ptr + 1;
        if(r_ptr > 3)   //si el transmitter leyo todos los datos, reiniciamos
        begin
            r_ptr = 0;
            aux_full = 0;
            count_w = 0;
        end
    end
end

always@(posedge wr)
begin
    if(wr & ~full)
    begin
        buffer[address] = w_data;
        count_w = count_w + 1;
        if(count_w > 3)
        begin
            aux_full = 1;
        end
    end
end

// Lectura
always@(*)
begin
    r_data <= buffer[r_ptr];
    DEBUGbuffer0 <= buffer[0];
    DEBUGbuffer1 <= buffer[1];
    DEBUGbuffer2 <= buffer[2];
    DEBUGbuffer3 <= buffer[3];
end

assign full = aux_full;
endmodule