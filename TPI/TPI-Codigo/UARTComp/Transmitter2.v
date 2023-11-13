module transmitter2(
    input wire clk, reset,
    input wire tx_start , s_tick,
    input wire [7:0] din,
    output reg tx_done_tick,
    output wire tx
);
// estados
localparam [1:0]
    idle = 2'b00,
    start = 2'b01,
    data = 2'b10,
    stop = 2'b11;

// cables internos
reg [1:0] state_reg , state_next;
reg [3:0] s_reg, s_next;
reg [2:0] n_reg, n_next;
reg [7:0] b_reg, b_next;
reg tx_reg, tx_next;

// body
always @(posedge clk, posedge reset)
    if (reset)
        begin
            state_reg <= idle;
            s_reg <= 0;
            n_reg <= 0;
            b_reg <= 0;
            tx_reg <= 1'b1;
        end
    else
        begin
            state_reg <= state_next;
            s_reg <= s_next;
            n_reg <= n_next;
            b_reg <= b_next;
            tx_reg <= tx_next;
        end
// Maquina de estados
always @*
    begin
    state_next = state_reg;
    tx_done_tick = 1'b0;
    s_next = s_reg;
    n_next = n_reg;
    b_next = b_reg;
    tx_next = tx_reg ;
case (state-reg)
idle :
begin
tx-next = l'bl;
if (tx-start)
begin
state-next = start;
s-next = 0;
b-next = din;
end
end
start :
begin
tx-next = l'bO;
if (s-tick)
if (s_reg==15)
begin
state-next = data;
s-next = 0;
n-next = 0;
end
else
s-next = s-reg + 1;
end
data:
begin
tx-next = b-reg [O] ;
if (s-tick)
if (s_reg==15)
begin
s-next = 0;
b-next = b-reg >> 1;
if (n-reg==(DBIT-1))
state-next = stop ;
else
n-next = n-reg + 1;
end
else
s-next = s-reg + 1;
endmodule