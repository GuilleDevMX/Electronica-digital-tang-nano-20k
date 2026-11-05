`timescale 1ns / 1ps
module pwm_top_tb;
reg clk;
reg [5:0]duty;
wire pwm;

pwm_top uut(clk, duty, pwm);

initial begin
    
    clk = 1'b0;
    forever #18.5 clk = ~clk;
end

initial begin
    duty = 6'b00_0000;
    #20000000
    duty = 6'b00_0001;
    #20000000
    duty = 6'b00_0010;
    #20000000
    duty = 6'b00_0011;
    #20000000
    duty = 6'b01_1110;
    #20000000
    duty = 6'b01_1111;
    #20000000
    duty = 6'b10_0000;
    #20000000
    duty = 6'b10_0001;
    #20000000
    duty = 6'b10_0010;
    #20000000
    duty = 6'b11_1100;
    #20000000
    duty = 6'b11_1101;
    #20000000;
    duty = 6'b11_1111;
    #20000000
    $finish;
end

endmodule