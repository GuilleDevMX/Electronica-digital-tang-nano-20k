`timescale 1ns / 1ps
module pwm_top(clk, duty, pwm);
input clk;
input [5:0]duty;
output pwm;

parameter SERVO_STEPS = 64;


wire [19:0]data;
wire reset_w;

counter u1(
    .clk(clk), // in
    .reset(reset_w), //in
    .delay_clk(data) //out
);

reset_module u2(
    .counter(data), //in
    .reset(reset_w) //out
);

comp #(
    .SERVO_STEPS(SERVO_STEPS)
    )
    u3(
    .duty(duty), //in
    .count(data), //in
    .pwm(pwm) //out
);

endmodule
