`timescale 1ns / 1ps
module UART(clk_top, clear, rx, tx, data_rx, payload_rx);
    input clk_top;
    input clear;
    input rx;
    output tx;
    output [9:0] data_rx;
    output [7:0] payload_rx;
    
    wire delay_w;
    wire end_char_w;
    wire start_char;
    wire [5:0]address_w;
    wire [9:0]data_w;

    // Señales internas para RX
    wire [5:0] address_rx_w;
    wire end_char_rx_w;
    wire shift_en_rx_w;
    
    baud_rate u0(
    .clk(clk_top), 
    .clear(clear), 
    .delay(delay_w) //out 
    );
    
    counter u1(
    .pulse(delay_w), //in
    .clear(clear),
    .address(address_w),
    .end_char(end_char_w)
    );
    
    or_module u2(
    .in_one(end_char_w), 
    .in_two(clear), 
    .reset_out(start_char)
    );
    
    memory u3(
    .address(address_w), //in
    .data(data_w) //out
    );
    
    shift_reg u4(
    .clk(delay_w), //in
    .reset(start_char),
    .data(data_w),
    .tx(tx)
    );

    counter_rx u5(
    .pulse(delay_w), //in
    .clear(clear),
    .rx(rx),
    .address_rx(address_rx_w),
    .end_char_rx(end_char_rx_w),
    .shift_en(shift_en_rx_w)
    );

    shift_reg_rx u6(
    .clk(delay_w), //in
    .clear(clear),
    .shift_en(shift_en_rx_w),
    .end_char_rx(end_char_rx_w),
    .rx(rx),
    .data_rx(data_rx),
    .payload_rx(payload_rx)
    );
endmodule
