`timescale 1ns / 1ps
module counter_rx(pulse, clear, rx, address_rx, end_char_rx, shift_en);
    input pulse;
    input clear;
    input rx;
    output reg [5:0] address_rx = 6'd0;
    output reg end_char_rx = 1'b0;
    output wire shift_en;
    
    reg [5:0] counter = 6'd0;

    // Habilita la captura de los 10 bits de la trama (1 Start + 8 Datos + 1 Stop)
    // Inicia cuando counter == 0 y detecta el bit de Start (rx == 0)
    assign shift_en = (counter == 6'd0) ? (rx == 1'b0) : (counter < 6'd10);

    always @(posedge pulse, posedge clear) begin
        if (clear) begin
            counter <= 6'd0;
            address_rx <= 6'd0;
            end_char_rx <= 1'b0;
        end
        else if (counter == 6'd0) begin
            end_char_rx <= 1'b0;
            if (rx == 1'b0) begin
                counter <= counter + 1;
            end
        end
        else if (counter == 6'd10 && address_rx <= 6'd58) begin
            counter <= 6'd0;
            address_rx <= address_rx + 1;
            end_char_rx <= 1'b1;
        end
        else begin
            end_char_rx <= 1'b0;
            counter <= counter + 1;
        end
    end
endmodule
