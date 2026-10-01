`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////
module counter4(div_clk, clear, cont);
    input div_clk;
    input clear;
    output reg [3:0]cont;

    always@(posedge clear, posedge div_clk)begin ////////////////////////////// always 2 
        if(clear) 
            cont <= 4'd0;
        else 
            cont <= cont + 1;
    end // always end 
endmodule