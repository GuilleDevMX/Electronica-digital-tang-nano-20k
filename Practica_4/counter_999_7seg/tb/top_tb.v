`timescale 1ns / 1ns

module tb_Counter_top();

    // Declaración de señales
    reg clk;
    reg rst;
    reg [7:0] dip_switch;
    reg stop_button;
    wire [3:0] an;
    wire [6:0] seg;
    wire dp;

    Counter_top #(.MAX_COUNT_BCD(15'h0999))dut (
        .clk(clk),
        .rst(rst),
        .dip_switch(dip_switch),
        .stop_button(stop_button),
        .an(an),
        .seg(seg),
        .dp(dp)
    );
    
    initial begin
        clk = 1;
        forever #1 clk = ~clk;
    end
    
    initial begin
        rst = 1'b1;
        stop_button = 1'd0;
        dip_switch = 8'd0;

        #20 rst = 1'b0;
        rst = 1'b0;

        #3 stop_button = 1'd1; 
        #3 stop_button = 1'd0;
        #1500;

        #3 stop_button = 1'd1; 
        #3 stop_button = 1'd0;
    end
    
    initial begin
        force dut.display_unit.clk_div = 17'd0;
        forever #20.625 force dut.display_unit.clk_div = dut.display_unit.clk_div + 17'h4000;
    end
    
    initial begin
        dut.m0.q[24] = 1'b1;
        forever #168 dut.m0.q[24] = ~dut.m0.q[24];
    end
    
    initial begin
       #1000000
        $finish;
    end

endmodule