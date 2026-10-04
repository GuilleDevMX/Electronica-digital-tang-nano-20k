module display_multiplexer (
    input wire clk,          // Clock (27 MHz for Tang Nano 20k)
    input wire rst,          // RESET
    input wire [15:0] data,  // 4 Digits BCD (data[15:12] to data[3:0])
    input wire [3:0] dp_in,  // Decimal control
    output reg [3:0] sel_dig,// Digit Select
    output wire [6:0] seg,   // Segments a-g
    output reg dp            // Decimal point
);

    // Clock divider; 17 bits to convert 27MHz to ~824Hz
    reg [16:0] clk_div;
    always @(posedge clk or posedge rst) begin
        if (rst) clk_div <= 17'd0;
        else clk_div <= clk_div + 1'b1;
    end

    // 16 and 15 are the select display to activate
    wire [1:0] mux_sel = clk_div[16:15];
    wire dead_time_phase = clk_div[14];
    reg [3:0] current_bcd;
    reg [3:0] sel_dig_internal;

    // Mux
    always @(*) begin
        case(mux_sel)
            2'b00: begin sel_dig_internal = 4'b0001; current_bcd = data[3:0]; dp = dp_in[0]; end
            2'b01: begin sel_dig_internal = 4'b0010; current_bcd = data[7:4]; dp = dp_in[1]; end
            2'b10: begin sel_dig_internal = 4'b0100; current_bcd = data[11:8]; dp = dp_in[2]; end
            2'b11: begin sel_dig_internal = 4'b1000; current_bcd = data[15:12]; dp = dp_in[3]; end
            default: begin sel_dig_internal = 4'b0000; current_bcd = 4'b0000; dp = 1'b0; end
        endcase
    end

    // Set a DeadTime for a good refresh
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