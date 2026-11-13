`timescale 1ns / 1ps
module hc_sr04_top (
    input clk,          // Reloj de 27 MHz
    input rst,          // Botón de reset
    input [7:0] dip_switch,    // 8 DIP Switch
    input echo,         // Entrada del sensor HC-SR04
    output trig,        // Salida al sensor HC-SR04
    output [3:0] an, // Selección de display
    output [6:0] seg,   // Segmentos a-g
    output dp           // Punto decimal
);

    wire measure;
    wire ready;
    wire [9:0] distance_cm;
    wire [15:0] bcd_data;

    // Generador de pulsos cada 250ms
    trigger_generator trigger_gen (
        .clk(clk),
        .rst(rst),
        .en(dip_switch[0]),
        .measure(measure)
    );

    // Controlador del sensor y conversor a centímetros
    hc_sr04_sensor sensor (
        .clk(clk),
        .rst(rst),
        .measure(measure),
        .echo(echo),
        .trig(trig),
        .ready(ready),
        .distance_cm(distance_cm)
    );

    // Convertidor Binario a BCD (para el multiplexor de displays)
    bin_to_bcd conversor_bcd (
        .bin(distance_cm),
        .bcd(bcd_data)
    );

    // Multiplexor de displays (proporcionado y ajustado)
    display_multiplexer display_mux (
        .clk(clk),
        .rst(rst),
        .data(bcd_data),
        .dp_in(4'b0000), // Puntos decimales apagados
        .sel_dig(an),
        .seg(seg),
        .dp(dp)
    );

endmodule