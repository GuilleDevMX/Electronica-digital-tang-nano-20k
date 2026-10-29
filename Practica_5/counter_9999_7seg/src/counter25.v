`timescale 1ns / 1ns
///////////////////////////////////////////////
module counter25(clk, reset, div_clk, fast_count);
    input clk;
    input reset;
    input fast_count;
    output div_clk;
    reg [24:0]q;
    
    always@(posedge reset, posedge clk)begin
        if(reset)
            q<=0;
        else
            q <= q + 1'd1;
        end
        
    assign div_clk = fast_count? q[24]: q[14];
endmodule