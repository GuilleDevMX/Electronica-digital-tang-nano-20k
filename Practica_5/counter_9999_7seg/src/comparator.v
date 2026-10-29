`timescale 1ns / 1ns
module comparator #(
    parameter [15:0] MAX_COUNT_BCD = 16'h1000,
    parameter [15:0] MIN_COUNT_BCD = 16'h0000
)(
    input [15:0] data,
    input up_down,
    output wire reset
);
    assign reset = (up_down) ? (data == MAX_COUNT_BCD) : (data == MIN_COUNT_BCD);

endmodule