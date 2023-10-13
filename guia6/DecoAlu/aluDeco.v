module aluDeco(
    input [5:0] op,
    input wire f7,
    input [2:0] f3,
    input [1:0] aluOp,
    output [2:0] aluControl
);

reg [2:0] aluControlAux = 0;

always @()
begin
    case (aluOp)
        2'b00:
            aluControlAux = 3'b000; //add
        2'b01:
            aluControlAux = 3'b001; //substract
        2'b10:
            case(f3)
                3'000:
                    if(f7 != 2'b11)begin
                        aluControlAux = 3'b000; //add
                    end else begin
                        aluControlAux = 3'001;  //substract
                    end
                3'010:
                    aluControlAux = 3'b101;     //set less than
                3'110:
                    aluControlAux = 3'b011;     //or
                3'111:
                    aluControlAux = 3'b010;     //and
            endcase
    endcase

    assign aluControl = aluControlAux;
end


endmodule