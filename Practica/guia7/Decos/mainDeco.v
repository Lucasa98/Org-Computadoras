module mainDeco(
    input [6:0] op,
    output wire branch,
    output wire resSrc,
    output wire memWrite,
    output wire aluSrc,
    output [1:0] inmSrc,
    output wire regWrite,
    output [1:0] aluOp
);

reg branchAux = 0;
reg resSrcAux = 0;
reg memWriteAux = 0;
reg aluSrcAux = 0;
reg [1:0] inmSrcAux = 0;
reg regWriteAux = 0;
reg [1:0] aluOpAux = 0;

always @(*)
begin
    case (op)
        3'd003:
        begin
            branchAux = 0;
            resSrcAux = 1;
            memWriteAux = 0;
            aluSrcAux = 1;
            inmSrcAux = 2'b00;
            regWriteAux = 1;
            aluOpAux = 2'b00;
        end
        3'd035:
        begin
            branchAux = 0;
            memWriteAux = 1;
            aluSrcAux = 1;
            inmSrcAux = 2'b01;
            regWriteAux = 0;
            aluOpAux = 2'b00;
        end
        3'd051:
        begin
            branchAux = 0;
            resSrcAux = 0;
            memWriteAux = 0;
            aluSrcAux = 0;
            regWriteAux = 1;
            aluOpAux = 2'b10;
        end
        3'd000:
        begin
            branchAux = 1;
            memWriteAux = 0;
            aluSrcAux = 0;
            inmSrcAux = 2'b10;
            regWriteAux = 0;
            aluOpAux = 2'b01;
        end
    endcase
end

assign branch = branchAux;
assign resSrc = resSrcAux;
assign memWrite = memWriteAux;
assign aluSrc = aluSrcAux;
assign inmSrc = inmSrcAux;
assign regWrite = regWriteAux;
assign aluOp = aluOpAux;

endmodule