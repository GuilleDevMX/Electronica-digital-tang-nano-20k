`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////
module Counter_top 
    #(
    parameter [15:0] MAX_COUNT_BCD = 16'h9999,
    parameter [15:0] MIN_COUNT_BCD = 16'h0000            
)(    
    input wire clk,                 // clk
    input wire rst,                 // reset
    input wire [7:0] dip_switch,    // 8 DIP Switch
    output wire [3:0] an,           // anode control
    output wire [6:0] seg,          // segs
    output wire dp                  // dp
);
    wire div_w;
    wire [15:0] cont_w;
    
    display_multiplexer display_unit (
        .clk(clk),
        .rst(rst),
        .data(cont_w),
        .dp_in(4'b0000),
        .sel_dig(an),
        .seg(seg),
        .dp(dp)
    );

    counter25 m0(
        .reset(rst),
        .clk(clk),
        .div_clk(div_w),
        .fast_count(dip_switch[6])
    );
    
    counter4 #(  
        .MAX_COUNT_BCD(MAX_COUNT_BCD),
        .MIN_COUNT_BCD(MIN_COUNT_BCD)
    ) m1 (
        .clear(rst),
        .div_clk(div_w),
        .data(cont_w),
        .up_down(dip_switch[7])
    );

    comparator #(
        .MAX_COUNT_BCD(16'hA000),
        .MIN_COUNT_BCD(16'hFFFF)
    ) m2 (
        .data(cont_w),
        .up_down(1'b1),
        .reset(in_two)
    );
    
    or_module m3(
        .in_one(rst),
        .in_two(in_two),
        .reset_out(reset_top)
    );
    
endmodule