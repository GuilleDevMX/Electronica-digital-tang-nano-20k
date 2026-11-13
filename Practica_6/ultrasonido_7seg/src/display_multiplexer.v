`timescale 1ns / 1ps

module display_multiplexer (
    input wire clk,          // Clock (27 MHz)
    input wire rst,          // RESET
    input wire [15:0] data,  // 4 Digits BCD
    input wire [3:0] dp_in,  // Decimal control
    output reg [3:0] sel_dig,// Digit Select
    output wire [6:0] seg,   // Segments a-g
    output reg dp            // Decimal point
);

    // Clock divider; 17 bits to convert 27MHz to ~103Hz multiplexing per display
    reg [16:0] clk_div;
    always @(posedge clk, posedge rst) begin
        if (rst) clk_div <= 17'd0;
        else clk_div <= clk_div + 1'b1;
    end

    wire [1:0] mux_sel = clk_div[16:15];
    wire dead_time_phase = clk_div[14];
    reg [3:0] current_bcd;
    reg [3:0] sel_dig_internal;

    always @(*) begin
        case(mux_sel)
            2'b00: begin sel_dig_internal = 4'b0001; current_bcd = data[15:12]; dp = dp_in[3]; end
            2'b01: begin sel_dig_internal = 4'b0010; current_bcd = data[11:8]; dp = dp_in[2]; end
            2'b10: begin sel_dig_internal = 4'b0100; current_bcd = data[7:4]; dp = dp_in[1]; end
            2'b11: begin sel_dig_internal = 4'b1000; current_bcd = data[3:0]; dp = dp_in[0]; end
            default: begin sel_dig_internal = 4'b0000; current_bcd = 4'b0000; dp = 1'b0; end
        endcase
    end

    always @(*) begin
        if (dead_time_phase)
            sel_dig = sel_dig_internal;
        else
            sel_dig = 4'b0000;
    end

    bcd_to_7seg decoder (
        .bcd(current_bcd),
        .seg(seg)
    );

endmodule

module bcd_to_7seg (
    input wire [3:0] bcd,
    output reg [6:0] seg // seg = {g, f, e, d, c, b, a}
);
    always @(*) begin
        case(bcd)
            4'h0: seg = 7'b0111111; 
            4'h1: seg = 7'b0000110; 
            4'h2: seg = 7'b1011011; 
            4'h3: seg = 7'b1001111; 
            4'h4: seg = 7'b1100110; 
            4'h5: seg = 7'b1101101; 
            4'h6: seg = 7'b1111101; 
            4'h7: seg = 7'b0000111; 
            4'h8: seg = 7'b1111111; 
            4'h9: seg = 7'b1101111;
            4'hA: seg = 7'b1110111; // Extra set to Hex
            4'hB: seg = 7'b1111100;
            4'hC: seg = 7'b0111001;
            4'hD: seg = 7'b1011110;
            4'hE: seg = 7'b1111001;
            4'hF: seg = 7'b1110001;
            default: seg = 7'b0000000; // Turn all to off
        endcase
    end
endmodule