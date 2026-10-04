`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////
module counter4(reset, up_down, div_clk, cont);
input reset;
input div_clk;
input up_down;
output reg [3:0]cont;

always@(posedge reset, posedge div_clk)begin 
    if(reset)
        cont <= 4'd0; 
    else begin
        if(up_down) begin
            if(cont!=4'd9)
                cont <= cont + 1; 
            else
                cont <= 4'd0; 
    end
    else begin
        if(cont!=0)
            cont <= cont - 1;
        else
            cont <= 4'd9; 
        end
    end // else end
end // always end 
endmodule