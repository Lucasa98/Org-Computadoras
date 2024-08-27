module mainDeco(
    input [6:0] op,
    output wire branch,
    output wire jump,
    output [1:0] resSrc,
    output wire memWrite,
    output wire aluSrc,
    output [1:0] immSrc,
    output wire regWrite,
    output [1:0] aluOp
);

reg branchAux = 0;
reg jumpAux = 0;
reg [1:0] resSrcAux = 0;
reg memWriteAux = 0;
reg aluSrcAux = 0;
reg [1:0] immSrcAux = 0;
reg regWriteAux = 0;
reg [1:0] aluOpAux = 0;

always @(*)
begin
    case (op)
        3:      //lw
        begin
            branchAux = 0;
            jumpAux = 0;
            resSrcAux = 2'b01;
            memWriteAux = 0;
            aluSrcAux = 1;
            immSrcAux = 2'b00;
            regWriteAux = 1;
            aluOpAux = 2'b00;
        end
        35:     //sw
        begin
            branchAux = 0;
            jumpAux = 0;
            memWriteAux = 1;
            aluSrcAux = 1;
            immSrcAux = 2'b01;
            regWriteAux = 0;
            aluOpAux = 2'b00;
        end
        51:     //R-Type
        begin
            branchAux = 0;
            jumpAux = 0;
            resSrcAux = 2'b00;
            memWriteAux = 0;
            aluSrcAux = 0;
            regWriteAux = 1;
            aluOpAux = 2'b10;
        end
        99:     //B-Type
        begin
            branchAux = 1;
            jumpAux = 0;
            memWriteAux = 0;
            aluSrcAux = 0;
            immSrcAux = 2'b10;
            regWriteAux = 0;
            aluOpAux = 2'b01;
        end
        19:     //I-Type
        begin
            branchAux = 0;
            jumpAux = 0;
            resSrcAux = 2'b00;
            memWriteAux = 0;
            aluSrcAux = 1;
            immSrcAux = 2'b00;
            regWriteAux = 1;
            aluOpAux = 2'b10;
        end
        111:        //jal
        begin
            branchAux = 0;
            jumpAux = 1;
            resSrcAux = 2'b10;
            memWriteAux = 0;
            immSrcAux = 2'b11;
            regWriteAux = 1;
        end
    endcase
end

assign branch = branchAux;
assign jump = jumpAux;
assign resSrc = resSrcAux;
assign memWrite = memWriteAux;
assign aluSrc = aluSrcAux;
assign immSrc = immSrcAux;
assign regWrite = regWriteAux;
assign aluOp = aluOpAux;

endmodule