module Transmitter
(
    input       clk,            //i_Clock
    input       tx_start,       //i_Tx_DV
    input [7:0] din,            //i_Tx_Byte
    output      o_Tx_Active,    //bandera de transmitiendo
    output reg Tx,             //Salida de dato en serie
    output      tx_done_tick      //
);

parameter CLKS_PER_BIT = 39;

//ESTADOS
parameter s_IDLE         = 3'b000;
parameter s_TX_START_BIT = 3'b001;
parameter s_TX_DATA_BITS = 3'b010;
parameter s_TX_STOP_BIT  = 3'b011;

reg [2:0]    r_SM_Main     = 0; //estado actual
reg [7:0]    r_Clock_Count = 0; //contador de ticks
reg [2:0]    r_Bit_Index   = 0; //puntero a bit del dato
reg [7:0]    r_Tx_Data     = 0; 
reg          r_Tx_Done     = 0;
reg          r_Tx_Active   = 0;
    
always @(posedge clk)
begin
    case (r_SM_Main)
    //ESTADO IDLE
    s_IDLE:
    begin
        Tx   <= 1'b1;  //Transmitir alto en IDLE
        r_Tx_Done     <= 1'b0;  //No transmitio nada
        r_Clock_Count <= 0;     //No cuenta ticks
        r_Bit_Index   <= 0;     //No avanza el bit de data
            
        if (tx_start == 1'b1)    //Si tx_start esta en alto
            begin
                r_Tx_Active <= 1'b1;            //Bandera de transmitiendo
                r_Tx_Data   <= din;             //Lee el dato de la FIFO
                r_SM_Main   <= s_TX_START_BIT;  //Pasa al estado START
            end
        else
            r_SM_Main <= s_IDLE;    //Bucle de estado
    end
        
    s_TX_START_BIT :
    begin
        Tx <= 1'b0;    //Envia el Start-bit
            
        // Espera CLKS_PER_BIT ticks para terminar el Start-bit
        if (r_Clock_Count < CLKS_PER_BIT-1)
            begin
                r_Clock_Count <= r_Clock_Count + 1;
                r_SM_Main     <= s_TX_START_BIT;
            end
        else    //Cuando termina el start bit
            begin
                r_Clock_Count <= 0;             //Reinicia el contador
                r_SM_Main     <= s_TX_DATA_BITS;//Pasa a estado DATA
            end
    end

    s_TX_DATA_BITS :
    begin
        // Envia a Tx el bit r_bit_index de Data
        Tx <= r_Tx_Data[r_Bit_Index];
        
        //Espera CLKS_PER_BIT ticks por cada bit de Data
        if (r_Clock_Count < CLKS_PER_BIT-1)
            begin
                r_Clock_Count <= r_Clock_Count + 1;
                r_SM_Main     <= s_TX_DATA_BITS;
            end
        else    //Cuando termina de enviar el bit
            begin
            r_Clock_Count <= 0; //Reinicia el contador de ticks

            if (r_Bit_Index < 7)    //Si quedan bits por mandar
                begin
                    r_Bit_Index <= r_Bit_Index + 1; //avanza el bit index
                    r_SM_Main   <= s_TX_DATA_BITS;  //bucle de estado
                end
            else    //Si ya envio todos los bits
                begin
                    r_Bit_Index <= 0;   //Reinicia el bit index
                    r_SM_Main   <= s_TX_STOP_BIT;   //Pasa al estado STOP
                end
            end
    end

    s_TX_STOP_BIT :
    begin
        //Envia el bit de Stop
        Tx <= 1'b1;
            
        //Envia el Stop-bit CLKS_PER_BIT ticks
        if (r_Clock_Count < CLKS_PER_BIT-1)
            begin
                r_Clock_Count <= r_Clock_Count + 1;
                r_SM_Main     <= s_TX_STOP_BIT;
            end
        else    //Cuando termina de enviar el Stop-bit
            begin
            r_Tx_Done     <= 1'b1;  //bandera de terminado
            r_Clock_Count <= 0;     //reinicia contador de ticks
            r_Tx_Active   <= 1'b0;  //bandera de no-transmitiendo
            r_SM_Main     <= s_IDLE;//Pasa a estado IDLE
            end
    end       

    default :
        r_SM_Main <= s_IDLE;
        
    endcase
end

assign o_Tx_Active = r_Tx_Active;
assign tx_done_tick   = r_Tx_Done;
   
endmodule