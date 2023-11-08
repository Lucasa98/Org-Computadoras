module Receiver
(
    input wire clk,             //i_clock
    input wire Rx,              //i_Rx_serial
    output wire Rx_done_tick,   //o_Rx_DV
    output [7:0] dout           //o_Rx_Byte
);

parameter CLKS_PER_BIT = 40;

//estados
parameter s_IDLE         = 3'b000;
parameter s_Rx_START_BIT = 3'b001;
parameter s_Rx_DATA_BITS = 3'b010;
parameter s_Rx_STOP_BIT  = 3'b011;

reg           r_Rx_Data_R = 1'b1;   //doble buffer
reg           r_Rx_Data   = 1'b1;

reg [7:0]     r_Clock_Count = 0;    //contador de ticks
reg [2:0]     r_Bit_Index   = 0;    //8 bits total
reg [7:0]     r_data_out    = 0;    //Data leida
reg           r_Rx_done_tick= 0;    //bandera de "termine de leer"
reg [2:0]     r_SM_Main     = 0;    //Estado actual

// Purpose: Double-register the incoming data.
// This allows it to be used in the UART Rx Clock Domain.
// (It removes problems caused by metastability)
// DE UNA
always @(posedge clk)
begin
    r_Rx_Data_R <= Rx;
    r_Rx_Data   <= r_Rx_Data_R;
end

// MAQUINA DE ESTADOS
always @(posedge clk)
begin
    case (r_SM_Main)
        s_IDLE:        // ESTADO IDLE
        begin
            r_Rx_done_tick       <= 1'b0;          //done = 0
            r_Clock_Count <= 0;
            r_Bit_Index   <= 0;
                
            if (r_Rx_Data == 1'b0)          // bit de inicio detectado
                r_SM_Main <= s_Rx_START_BIT;// Pasa al estado START
            else
                r_SM_Main <= s_IDLE;        // SI no sigue en IDLE
        end
    
        // ESTADO START
        // Check middle of start bit to make sure it's still low
        s_Rx_START_BIT :
        begin
            if (r_Clock_Count == (CLKS_PER_BIT-1)/2)    //si esta a la mitad del clk
                begin
                if (r_Rx_Data == 1'b0)  // si Rx esta en bajo
                    begin   // empieza el muestreo y pasa al leer DATA
                        //ACA ESTARIAMOS PARADOS A LA MITAD DEL BIT DE INICIO
                        r_Clock_Count <= 0;  // reset counter, found the middle
                        r_SM_Main     <= s_Rx_DATA_BITS;
                    end
                else
                    //ACA LEYO CUALQUIER COSA, VUELVE A IDLE
                    r_SM_Main <= s_IDLE;
                end
            else
                begin
                    r_Clock_Count <= r_Clock_Count + 1;
                    r_SM_Main     <= s_Rx_START_BIT;    // bucle de estado
                end
        end
        
        //ESTADO DATA
        // Wait CLKS_PER_BIT-1 clock cycles to sample serial data
        s_Rx_DATA_BITS :
        begin
            if (r_Clock_Count < CLKS_PER_BIT-1) //todavia no se fija el valor de Rx
                begin
                    r_Clock_Count <= r_Clock_Count + 1;
                    r_SM_Main     <= s_Rx_DATA_BITS;
                end
            else    //Llego a la mitad del siguiente clk
                begin
                    r_Clock_Count          <= 0;            //reinicia la cuenta del muestre
                    r_data_out[r_Bit_Index] <= r_Rx_Data;    //guardo el bit en el lugar al que apunta el bit index
                        
                    if (r_Bit_Index < 7)        //Si todavia no recibio toda la palabra
                        begin
                            r_Bit_Index <= r_Bit_Index + 1; //avanza el bit index
                            r_SM_Main   <= s_Rx_DATA_BITS;  //bucle de estado
                        end
                    else                        //Si recibio toda la palabra
                        begin
                            r_Bit_Index <= 0;   //reinicia el bit index
                            r_SM_Main   <= s_Rx_STOP_BIT;   //Pasa al estado de STOP
                        end
                end
        end
    
        //ESTADO STOP
        // Receive Stop bit.  Stop bit = 1
        s_Rx_STOP_BIT :
        begin
            // Wait CLKS_PER_BIT-1 clock cycles for Stop bit to finish
            if (r_Clock_Count < CLKS_PER_BIT-1) //si no llego a la mitad del bit de stop
                begin
                    r_Clock_Count <= r_Clock_Count + 1;
                    r_SM_Main     <= s_Rx_STOP_BIT;
                end
            else    //cuando llega a la mitad del bit de stop
                begin
                    r_Rx_done_tick       <= 1'b1;      //bandera de que termino de leer
                    r_Clock_Count <= 0;         //reinicia el contador
                    r_SM_Main     <= s_IDLE; //Pasa a CLEANUP
                end
        end
        
        default :
            r_SM_Main <= s_IDLE;
    endcase
end   

assign Rx_done_tick   = r_Rx_done_tick;
assign dout = r_data_out;

endmodule