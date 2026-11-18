`timescale 1ns / 1ps
module shift_reg_rx(clk, clear, shift_en, end_char_rx, rx, data_rx, payload_rx);
    input clk;
    input clear;
    input shift_en;
    input end_char_rx;
    input rx;
    output reg [9:0] data_rx = 10'b1111111111;
    output [7:0] payload_rx;

    reg [9:0] tmp = 10'b1111111111;

    // Registro de corrimiento Serie-a-Paralelo (SIPO) de 10 bits
    always @(posedge clear, posedge clk) begin
        if (clear)
            tmp <= 10'b1111111111;
        else if (shift_en)
            tmp <= {rx, tmp[9:1]};
    end

    // Captura la trama completa de 10 bits {STOP_BIT, payload[7:0], START_BIT} al terminar el caracter
    always @(posedge clear, posedge end_char_rx) begin
        if (clear)
            data_rx <= 10'b1111111111;
        else
            data_rx <= tmp;
    end

    // Dato ASCII de 8 bits recibido (sin bit de Start ni bit de Stop)
    assign payload_rx = data_rx[8:1];
endmodule
