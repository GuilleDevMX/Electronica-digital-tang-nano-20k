`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////
module comparator(cont, reset);
    input [3:0]cont;
    output reset; // in_two 
    
    assign reset = (cont == 4'd10)? 1: 0;	// Cuentas hasta 6
endmodule
