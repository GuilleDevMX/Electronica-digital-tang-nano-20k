`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////
module comparator(cont, reset);
    input [3:0]cont;
    output wire reset;
    
    assign reset = (cont==4'd10 || cont==4'd15)? 1 : 0;
endmodule