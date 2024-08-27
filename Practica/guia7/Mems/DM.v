module DM(
    input wire clk,
    input [15:0] address,
    input [31:0] wd,
    input wire we,
    output [31:0] rd
);

reg[31:0] dataBank[31:0];
integer i;

initial
begin
    for(i = 0;i<32;i=i+1) begin
        dataBank[i] <= 32'h00000000;
    end
end

always @(posedge clk)
begin
    if(we)
    begin
        dataBank[address] <= wd;
        //que escriba
    end
    //bla
end

assign rd = dataBank[address];

endmodule