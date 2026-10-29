`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////
module counter_stop(clk, reset, in_stop, out_stop_s);
    input wire clk;
    input wire reset;
    input wire in_stop;
    output wire out_stop_s;
    
    reg stop_h;
    reg in_stop_d1, in_stop_d2;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            stop_h <= 1'b1;
            in_stop_d1 <= 1'b0;
            in_stop_d2 <= 1'b0;
        end else begin
            in_stop_d1 <= in_stop;
            in_stop_d2 <= in_stop_d1;
            
            if (in_stop_d1 && !in_stop_d2) begin
                stop_h <= ~stop_h;
            end
        end
    end

    assign out_stop_s = stop_h;
endmodule
