`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////
module or_module(in_one, in_two, reset_out);
    input in_one;
    input in_two;
    output reset_out;
    
    assign reset_out = in_one || in_two;
    
endmodule