`timescale 1ns/1ps
module UART_tb;
    reg clk;
    reg clear;
    wire tx;
    wire [9:0] data_rx;
    wire [7:0] payload_rx;

    // Conexion en loopback (rx recibe lo enviado por tx)
    UART uut(
        .clk_top(clk),
        .clear(clear),
        .rx(tx),
        .tx(tx),
        .data_rx(data_rx),
        .payload_rx(payload_rx)
    );
    
    initial begin
        clk = 0;
        clear=1;
        #1;
        clear=0;
        #16712000;
        $stop;
    end 
    
    always
        #18.51852 clk = ! clk; 
endmodule
