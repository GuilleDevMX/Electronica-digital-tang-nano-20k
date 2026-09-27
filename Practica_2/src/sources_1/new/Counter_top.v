`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////
module Counter_top(clear_top, clk, a, b, c, d, e, f, g);
    input clear_top;
    input clk;
    output a, b, c, d, e, f, g;
    
    wire clk_div_w;
    wire reset_top;
    wire in_two;
    wire [3:0]cont_w;
    
    counter25 m0(
    .reset(clear_top),
    .clk(clk),
    .div_clk(clk_div_w)
    );
    
    counter4 m1(
    .clear(reset_top),
    .div_clk(clk_div_w),
    .cont(cont_w)
    );
    
    comparator m2(
    .cont(cont_w),
    .reset(in_two)
    );
    
    or_module m3(
    .in_one(clear_top),
    .in_two(in_two),
    .reset_out(reset_top)
    );
    
    decoder m4(
    .data(cont_w),
    .a(a),
    .b(b),
    .c(c),
    .d(d),
    .e(e),
    .f(f),
    .g(g)
    );
endmodule