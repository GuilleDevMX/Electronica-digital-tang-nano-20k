`timescale 1ns / 1ps

module bin_to_bcd (
    input [9:0] bin,
    output reg [15:0] bcd
);
    integer i;
    always @(*) begin
        bcd = 16'd0;
        for (i = 9; i >= 0; i = i - 1) begin
            if (bcd[3:0] >= 5) bcd[3:0] = bcd[3:0] + 3;
            if (bcd[7:4] >= 5) bcd[7:4] = bcd[7:4] + 3;
            if (bcd[11:8] >= 5) bcd[11:8] = bcd[11:8] + 3;
            if (bcd[15:12] >= 5) bcd[15:12] = bcd[15:12] + 3;
            bcd = {bcd[14:0], bin[i]};
        end
    end
endmodule
