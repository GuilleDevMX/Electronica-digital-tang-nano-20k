`timescale 1ns / 1ns
module comparator #(
    parameter [15:0] MAX_COUNT_BCD = 16'h1000 // Parámetro para el límite BCD
)(
    input [15:0] data,
    output wire reset
);
    // Reinicia cuando la cuenta alcanza exactamente el límite configurado
    assign reset = (data == MAX_COUNT_BCD) ? 1'b1 : 1'b0;
endmodule