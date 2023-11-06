module MMU(
    input wire [15:0] address_virtual,
    output reg [1:0] block_select,
    output reg [15:0] address_physical,
    output reg DataEnable,
    output reg StackEnable,
    output reg MMIOEnable
);
// Definición de direcciones virtuales
parameter DATA_ADDRESS = 16'h2000;
parameter STACK_ADDRESS = 16'h3ffc;
parameter MMIO_ADDRESS = 16'h7f00;
// Definición de tamaño de bloque (32 registros de 32 bits)
parameter BLOCK_SIZE = 32;
// Mapeo de direcciones virtuales a bloques de datos
always @(*) begin
 block_select = 2'b00;
 DataEnable = 0;
 StackEnable = 0;
 MMIOEnable = 0;

 if (address_virtual >= DATA_ADDRESS && address_virtual < DATA_ADDRESS + BLOCK_SIZE) begin
    // Acceso al bloque .data
    block_select = 2'b00;
    address_physical = address_virtual - DATA_ADDRESS;
    DataEnable = 1;
 end else if (address_virtual <= STACK_ADDRESS && address_virtual > STACK_ADDRESS - BLOCK_SIZE) begin
    // Acceso al bloque .stack
    block_select = 2'b01;
    address_physical = STACK_ADDRESS - address_virtual;
    StackEnable = 1;
 end else if (address_virtual >= MMIO_ADDRESS && address_virtual < MMIO_ADDRESS + BLOCK_SIZE) begin
    // Acceso al bloque .MMIO
    block_select = 2'b10;
    address_physical = address_virtual - MMIO_ADDRESS;
    MMIOEnable = 1;
 end
end
endmodule