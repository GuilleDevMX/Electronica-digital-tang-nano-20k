`timescale 1ns / 1ps
module baud_rate(clk, clear, delay);

    parameter nclks = 703; // 38400 Bauds @ 27MHz
    // parameter nclks = 2812; // 9600 Bauds @ 27MHz
    input clk;
    input clear;
    output reg delay;
    
    reg [11:0] c;
    
    always@(posedge clear, posedge clk) begin
        if(clear)
            c <= 0;
        else if(c >= nclks)
            c <= 0;
        else
            c <= c + 1;
    end
    
    always @(posedge clk) begin
        delay <= (c == nclks);
    end
    
endmodule