`timescale 1ns / 1ps

module counter (clk, reset, delay_clk);

input clk;
input reset;
output reg[19:0]delay_clk = 0; //540000d

always@(posedge reset,posedge clk) begin
    if(reset)
        delay_clk <= 0;
    else
        delay_clk<=delay_clk+1;
    end

endmodule