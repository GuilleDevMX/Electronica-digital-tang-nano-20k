`timescale 1ns / 1ps
module counter(pulse, clear, address, end_char);
    input pulse;
    input clear;
    output reg [5:0] address = 6'd0;
    output reg end_char = 1'b1;
    
    reg [5:0]counter = 6'd0;

    always@(posedge pulse, posedge clear) begin
        if(clear) begin
            counter <= 6'd0;
            address <= 6'd0;
            end_char <= 1'b1;
        end
        else if(counter == 6'd10 && address <= 6'd58)begin
                counter <= 6'd0;
                address <= address +1;
                end_char <= 1'b1;end
            else begin
                end_char <= 1'b0; 
                counter <= counter + 1; 
            end
    end
endmodule