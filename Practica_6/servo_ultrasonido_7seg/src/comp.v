`timescale 1ns / 1ps
module comp
#(parameter SERVO_STEPS = 64)
(duty,count,pwm);

input wire [5:0] duty;   // dip-switch
input wire [19:0] count; // each count is each 37ns from a clock with 27 MHz
output reg pwm;

localparam PAD = 27027;
localparam STEP = PAD / (SERVO_STEPS - 1);

always @(*) begin
    if (duty < SERVO_STEPS) begin
        pwm = (count < (PAD + (duty * STEP)));
    end 
    else begin
        pwm = 1'b0;
    end
end

endmodule