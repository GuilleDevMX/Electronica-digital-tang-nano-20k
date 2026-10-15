`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////
module counter4(div_clk, clear, data);
    input div_clk;
    input clear;
    output reg [15:0] data; // units [3:0], tens [7:4],hundreds [11:8], thousand [15:12] 
    
    always@(posedge clear, posedge div_clk)begin 
        if(clear) begin
            data[3:0] <= 4'd0;
            data[7:4] <= 4'd0; 
            data[11:8] <= 4'd0;
            data[15:12] <= 4'd0; 
        end
        else begin
            if(data[3:0] == 4'd9)begin
                data[3:0] <= 4'd0;
                data[7:4] <= data[7:4] + 1'd1;
            end
        else
            data[3:0] <= data[3:0] + 1'd1; 
        end    
    end
endmodule
