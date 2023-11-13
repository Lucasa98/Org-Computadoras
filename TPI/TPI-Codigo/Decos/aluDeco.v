module aluDeco(
    input wire op,
    input wire f7,
    input [2:0] f3,
    input [1:0] aluOp,
    output [2:0] aluControl
);

reg[2:0] aluControlAux = 3'b000;

always @(*)
begin
    case (aluOp)
        2'b00:
            aluControlAux = 3'b000; //add
        2'b01:
            case(f3)
                3'b000:
                    aluControlAux = 3'b100; //BEQ
                3'b100:
                    aluControlAux = 3'b101;//BLT
                default:
                    aluControlAux = 3'b001; //substract
            endcase
        2'b10:
            case(f3)
                3'b000:
                    if(f7 && op)
                    begin
                        aluControlAux = 3'b001; //substract
                    end else begin
                        aluControlAux = 3'b000;  //add
                    end
                3'b010:
                    aluControlAux = 3'b101;     //set less than
                3'b110:
                    aluControlAux = 3'b011;     //or
                3'b111:
                    aluControlAux = 3'b010;     //and
            endcase
    endcase
end

assign aluControl = aluControlAux;

endmodule