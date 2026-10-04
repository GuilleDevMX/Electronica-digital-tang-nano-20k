`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////

module toggle_mode
    #(parameter MAX_COUNT = 4'd9)
    (count, n_up_down);
    
    input [3:0] count;
    output reg n_up_down;
    
    always@(*) begin
        if (count == 0)
            n_up_down <= 1;
        else if (count == MAX_COUNT)
            n_up_down <= 0;
    end
endmodule
