`timescale 1ns / 1ps
module hc_rs04_tb();

    reg clk;                // Reloj de 27 MHz
    reg rst;                // Botón de reset
    reg [7:0] dip_switch;   // 8 DIP Switch
    reg echo;               // Entrada del sensor HC-SR04
    wire trig;              // Salida al sensor HC-SR04
    wire [3:0] an;          // Selección de display
    wire [6:0] seg;         // Segmentos a-g
    wire dp;                // Punto decimal
    
    hc_sr04_top uut(
    .clk(clk),
    .rst(rst),
    .dip_switch(dip_switch),
    .echo(echo),
    .trig(trig),
    .an(an),
    .seg(seg),
    .dp(dp)
    );
    
    initial begin
        clk = 1'b0;
        forever #18.5 clk = ~clk;
    end
    
    initial begin 
       // Inicialización de señales
       dip_switch = 8'b0000_0000; // Establecemos los dip switch en 00
       echo = 1'b0;
       rst = 1'b1;                // Reseteamos el sistema
       
       repeat (2) @(posedge clk);
       #1;
       rst = 1'b0;

       // =====================================================================
       // RUTINA 1: Medición de 10 cm (Pulso Echo = 10 * 58 us = 580 us)
       // =====================================================================
       dip_switch = 8'b0000_0001; // Habilitamos la secuencia de disparo (IDLE -> TRIGGER)

       // Esperamos a que se genere el pulso measure y finalice el pulso trig (~271 ciclos = 10 us)
       // Estado pasa de TRIGGER -> WAIT_ECHO
       repeat (275) @(posedge clk);
       
       // Generamos pulso de echo de 580 us (580,000 ns) correspondiente a 10 cm
       // Estado pasa de WAIT_ECHO -> COUNT_ECHO (1566 ciclos por cada cm)
       echo = 1'b1;
       #580_000;
       echo = 1'b0; // Estado regresa a IDLE y actualiza distance_cm = 10
       
       repeat (10) @(posedge clk);

       // =====================================================================
       // RUTINA 2: Medición de 20 cm (Pulso Echo = 20 * 58 us = 1,160 us)
       // =====================================================================
       dip_switch = 8'b0000_0000; // Reiniciamos el generador de disparo
       repeat (2) @(posedge clk);
       dip_switch = 8'b0000_0001; // Habilitamos nuevo disparo (IDLE -> TRIGGER)

       // Esperamos los 271 ciclos del pulso de trigger (TRIGGER -> WAIT_ECHO)
       repeat (275) @(posedge clk);

       // Generamos pulso de echo de 1,160 us (1,160,000 ns) correspondiente a 20 cm
       echo = 1'b1;
       #1_160_000;
       echo = 1'b0; // Estado regresa a IDLE y actualiza distance_cm = 20

       repeat (10) @(posedge clk);

       // =====================================================================
       // RUTINA 3: Medición de 50 cm (Pulso Echo = 50 * 58 us = 2,900 us)
       // =====================================================================
       dip_switch = 8'b0000_0000; // Reiniciamos el generador de disparo
       repeat (2) @(posedge clk);
       dip_switch = 8'b0000_0001; // Habilitamos nuevo disparo (IDLE -> TRIGGER)

       // Esperamos los 271 ciclos del pulso de trigger (TRIGGER -> WAIT_ECHO)
       repeat (275) @(posedge clk);

       // Generamos pulso de echo de 2,900 us (2,900,000 ns) correspondiente a 50 cm
       echo = 1'b1;
       #2_900_000;
       echo = 1'b0; // Estado regresa a IDLE y actualiza distance_cm = 50

       // Esperamos tiempo suficiente para observar la actualización final y el display
       repeat (500) @(posedge clk);
       $finish;
    end
    
endmodule
