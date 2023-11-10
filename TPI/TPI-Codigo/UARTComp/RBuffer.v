module RBuffer(
    input clk,
    input wire wr,            //señal de escritura
    input [7:0] w_data,       //dato de escritura
    input [2:0] address,      //Dirección de lectura
    output reg [7:0] r_data,  //dato de lectura

    output reg[7:0] DEBUGBuffer0,
    output reg[7:0] DEBUGBuffer1,
    output reg[7:0] DEBUGBuffer2,
    output reg[7:0] DEBUGBuffer3,
    output reg[7:0] DEBUGBuffer4,
    output reg[7:0] DEBUGBuffer5
);

//punteros de escritura y lectura
reg [2:0] w_ptr;
reg [7:0] buffer[5:0];

// Valores por defecto
initial
begin
    w_ptr <= 0;
    r_data <= 0;
    buffer[5] <=0;  //full=0
end

// Escritura
always@(posedge clk)
begin
    if(wr)
    begin
        buffer[5] = 0;  //full=0
        buffer[w_ptr] = w_data;
        w_ptr = w_ptr + 1;
        if(w_ptr > 4)
        begin
            buffer[5] = 1; //full=1
            w_ptr = 0;
        end
    end
end

// Lectura
always@(*)
begin
    r_data <= buffer[address];
    DEBUGBuffer0 <= buffer[0];
    DEBUGBuffer1 <= buffer[1];
    DEBUGBuffer2 <= buffer[2];
    DEBUGBuffer3 <= buffer[3];
    DEBUGBuffer4 <= buffer[4];
    DEBUGBuffer5 <= buffer[5];
end
endmodule