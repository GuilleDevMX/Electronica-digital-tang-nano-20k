`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////
module comparator(data, reset);
    input [15:0] data;
    output wire reset;
    
    assign reset = (data[7:4] == 4'd10 && data[3:0] == 4'd0)? 1 : 0;
endmodule