module FIFO(
    input wire wr,            //señal de escritura
    input wire rd,            //señal de lectura
    input [7:0] w_data,       //dato de escritura
    output reg [7:0] r_data,  //dato de lectura
    output wire full,         //bandera de llena
    output wire empty         //bandera de vacia
);

//punteros de escritura y lectura
//--un bit adicional para detectar full/empty--
reg [2:0] w_ptr, r_ptr;
reg [7:0] fifo[4];
wire wrap_around;

// Valores por defecto
initial
begin
    w_ptr <= 0; r_ptr <= 0;
    r_data <= 0;
end

// Escritura
always@(posedge wr)
begin
    if(wr & !full)begin
        fifo[w_ptr[1:0]] <= w_data;
        w_ptr <= w_ptr + 1;
    end
end

// Lectura
always@(posedge rd)
begin
    if(rd & !empty) begin
        r_ptr <= r_ptr + 1;
    end
end

always@(*)
begin
    r_data <= fifo[r_ptr[1:0]];
end

//Chequeo para full y empty
assign wrap_around = w_ptr[2] ^ r_ptr[2];
assign full = wrap_around & (w_ptr[1:0] == r_ptr[1:0]);
assign empty = (w_ptr == r_ptr);
endmodule