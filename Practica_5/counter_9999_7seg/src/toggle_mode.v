`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////

module toggle_mode #(
    parameter [15:0] MAX_COUNT_BCD = 16'h1000,
    parameter [15:0] MIN_COUNT_BCD = 16'h0000
)(
    input clk,
    input rst,
    input [15:0] count,
    output wire n_up_down
);
    
    reg state_dir = 1'b1; 

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state_dir <= 1'b1;
        end else begin
            if (count == MIN_COUNT_BCD)
                state_dir <= 1'b1;
            else if (count == MAX_COUNT_BCD)
                state_dir <= 1'b0;
        end
    end

    assign n_up_down = (count == MAX_COUNT_BCD) ? 1'b0 :
                       (count == MIN_COUNT_BCD) ? 1'b1 :
                       state_dir;

endmodule