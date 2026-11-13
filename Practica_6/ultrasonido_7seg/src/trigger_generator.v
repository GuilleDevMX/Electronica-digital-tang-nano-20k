`timescale 1ns / 1ps
module trigger_generator (
    input clk,
    input rst,
    input en,
    output measure
);
    reg [22:0] counter;
    
    // Pulso cuando el contador es 1
    assign measure = (counter == 23'd1);

    always @(posedge clk, posedge rst) begin
        if (rst) begin
            counter <= 23'd0;
        end else if (~en | (counter == 23'd6_750_000)) begin
            counter <= 23'd0;
        end else begin
            counter <= counter + 1'b1;
        end
    end
endmodule