module TEST(
    input clk,
    input BTN,
    output [3:0] LEDS
);

reg[3:0] bank;
reg[3:0] aux_leds;

initial begin
    bank = 0;
    aux_leds=0;
end

always@(posedge clk)
begin
    if(BTN == 1)
    begin
        bank = bank + 1;
    end
    aux_leds = bank;
end

assign LED = aux_leds;

endmodule