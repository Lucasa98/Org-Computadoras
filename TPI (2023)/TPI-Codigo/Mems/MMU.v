module MMU(
    input wire [15:0] address_virtual,
    input wire we,
    output reg [1:0] block_select,
    output reg [15:0] address_physical,
    output reg DataEnable,
    output reg StackEnable,
    output reg UARTEnable
);
// Definición de direcciones virtuales
parameter DATA_ADDRESS = 16'h0000;
parameter STACK_ADDRESS = 16'h0400;
parameter UART_ADDRESS = 16'h0800;
// Definición de tamaño de bloque (32 registros de 32 bits)
parameter BLOCK_SIZE = 64;
// Mapeo de direcciones virtuales a bloques de datos
always @(*) begin
 block_select = 2'b00;
 DataEnable = 0;
 StackEnable = 0;
 UARTEnable = 0;

 if (address_virtual >= DATA_ADDRESS && address_virtual < DATA_ADDRESS + BLOCK_SIZE) begin
    // Acceso al bloque .data
    block_select = 2'b00;
    address_physical = address_virtual - DATA_ADDRESS;
    DataEnable = we;
 end else if (address_virtual <= STACK_ADDRESS && address_virtual > STACK_ADDRESS - BLOCK_SIZE) begin
    // Acceso al bloque .stack
    block_select = 2'b01;
    address_physical = STACK_ADDRESS - address_virtual;
    StackEnable = we;
 end else if (address_virtual >= UART_ADDRESS && address_virtual < UART_ADDRESS + BLOCK_SIZE) begin
    // Acceso al bloque .UART
    block_select = 2'b10;
    address_physical = address_virtual - UART_ADDRESS;
    UARTEnable = we;
 end
end
endmodule