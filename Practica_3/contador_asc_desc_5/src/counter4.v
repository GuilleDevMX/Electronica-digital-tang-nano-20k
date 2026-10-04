`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////
module counter4
#(parameter MAX_COUNT = 4'd9)
(reset, div_clk, cont);

input reset;
input div_clk;
output reg [3:0]cont;

wire up_down;

toggle_mode #(.MAX_COUNT(MAX_COUNT)) m4(
    .count(cont),
    .n_up_down(up_down)
);

always@(posedge reset, posedge div_clk)begin 
    if(reset)
        cont <= 4'd0; 
    else begin
        if(up_down) begin
            if(cont!=MAX_COUNT)
                cont <= cont + 1; 
            else
                cont <= 4'd0; 
    end
    else begin
        if(cont!=0)
            cont <= cont - 1;
        else
            cont <= MAX_COUNT; 
        end
    end // else end
end // always end 
endmodule