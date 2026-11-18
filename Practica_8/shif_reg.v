`timescale 1ns / 1ps
module shift_reg(clk, reset, data, tx);
    input clk;
    input reset;
    input [9:0] data;
    output tx;
    
    reg [9:0] tmp; 
    reg si = 1'b1;
    
    always @(posedge reset, posedge clk) begin
        if(reset) 
            tmp <= data;
        else
            tmp <= {si,tmp[9:1]};
    end
        
    assign tx = reset ? 1'b1 : tmp[0];
endmodule

