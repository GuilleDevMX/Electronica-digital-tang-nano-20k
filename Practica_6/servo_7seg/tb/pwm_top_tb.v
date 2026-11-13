`timescale 1ns / 1ps

module pwm_top_tb;

reg clk;
reg rst;
reg [7:0] dip_switch; 
wire [3:0] an;
wire [6:0] seg;
wire dp;
wire pwm;
|
localparam MAX_STEP = 16;

pwm_top #(
    .SERVO_STEPS(MAX_STEP)
) uut (
    .clk(clk), 
    .rst(rst), 
    .dip_switch(dip_switch), 
    .an(an), 
    .seg(seg), 
    .dp(dp), 
    .pwm(pwm)
);

initial begin
    clk = 1'b0;
    forever #18.5 clk = ~clk;
end

integer a[0:8]; 
integer i;

initial begin
    a[0] = 0; a[1] = 1; a[2] = 2; a[3] = 3;
    a[4] = 6; a[5] = 7; a[6] = 8; a[7] = 16;

    dip_switch = 8'b0;
    rst = 1'b1;
    
    repeat (2) @(posedge clk);
    #1;
    rst = 1'b0;
    
    for (i = 0; i < 9; i = i + 1) begin
        repeat (540540) @(posedge clk); 
        
        #1;
        dip_switch = a[i];
    end
    
    repeat (10) @(posedge clk);
    $finish;
end

endmodule

