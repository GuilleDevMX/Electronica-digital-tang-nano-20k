`timescale 1ns / 1ns
///////////////////////////////////////////////
module counter25(clk, reset, div_clk);
    input clk;
    input reset;
    output wire div_clk;
    
    parameter limit = 25'd27_000_000;
    reg [24:0]q;
    
    always@(posedge reset, posedge clk)begin
        if(reset || q == limit)
            q<=25'd0;
        else
            q <= q + 1;
        end //always end
    
    assign div_clk = q[24];
endmodule