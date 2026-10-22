`timescale 1ns / 1ns

module tb_Counter_top();

    // Declaración de señales
    reg clk;
    reg rst;
    reg [7:0] dip_switch;
    wire [3:0] an;
    wire [6:0] seg;
    wire dp;

    // Instanciación del Top Module (DUT)
    Counter_top dut (
        .clk(clk),
        .rst(rst),
        .dip_switch(dip_switch),
        .an(an),
        .seg(seg),
        .dp(dp)
    );
    
    // Generación del reloj principal (27MHz -> periodo de ~37.03ns)
    initial begin
        clk = 0;
        forever #18.5 clk = ~clk;
    end
    
    initial begin
        rst = 1'b1;
        dip_switch = 8'd0;
        #20 rst = 1'b0; 
    end
    

    initial begin
        force dut.display_unit.clk_div = 17'd0;
        // Sumar 17'h4000 estimula clk_div[14] (dead_time_phase)
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
