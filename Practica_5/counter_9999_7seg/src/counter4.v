`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////
module counter4 #(
    parameter [15:0] MAX_COUNT_BCD = 16'hA000,
    parameter [15:0] MIN_COUNT_BCD = 16'h0000
)(
    input div_clk,
    input clear,
    input up_down,
    output reg [15:0] data // units [3:0], tens [7:4], hundreds [11:8], thousand [15:12] 
);

    wire up_down;

//    toggle_mode #(
//        .MAX_COUNT_BCD(MAX_COUNT_BCD),
//        .MIN_COUNT_BCD(MIN_COUNT_BCD)
//    ) m4 (
//        .clk(div_clk),
//        .rst(clear),
//        .count(data),
//        .n_up_down(up_down)
//    );
    
    always @(posedge clear, posedge div_clk) begin 
        if (clear) begin
            data <= MIN_COUNT_BCD;
        end
        else begin
            if (up_down) begin

                if (data[3:0] == 4'd9) begin
                    data[3:0] <= 4'd0;
                    
                    if (data[7:4] == 4'd9) begin 
                        data[7:4] <= 4'd0;
                        
                        if (data[11:8] == 4'd9) begin
                            data[11:8] <= 4'd0;
                            
                            if (data[15:12] == 4'd9) begin
                                data[15:12] <= 4'd0;
                            end else begin
                                data[15:12] <= data[15:12] + 1'b1;
                            end
                            
                        end else begin
                            data[11:8] <= data[11:8] + 1'b1;
                        end
                        
                    end else begin
                        data[7:4] <= data[7:4] + 1'b1;
                    end
                    
                end else begin
                    data[3:0] <= data[3:0] + 1'b1; 
                end
                
            end else begin

                if (data[3:0] == 4'd0) begin
                    data[3:0] <= 4'd9;
                    
                    if (data[7:4] == 4'd0) begin
                        data[7:4] <= 4'd9;
                        
                        if (data[11:8] == 4'd0) begin
                            data[11:8] <= 4'd9;
                            
                            if (data[15:12] == 4'd0) begin
                                data[15:12] <= 4'd9;
                            end else begin
                                data[15:12] <= data[15:12] - 1'b1;
                            end
                            
                        end else begin
                            data[11:8] <= data[11:8] - 1'b1;
                        end
                        
                    end else begin
                        data[7:4] <= data[7:4] - 1'b1;
                    end
                    
                end else begin
                    data[3:0] <= data[3:0] - 1'b1;
                end
            end 
        end
    end
endmodule