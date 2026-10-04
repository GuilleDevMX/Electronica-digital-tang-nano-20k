`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////
module Counter_top(    
    input wire clk,                 // clk
    input wire rst,                 // reset
    input wire [7:0] dip_switch,    // 8 DIP Switch
    output wire [3:0] an,           // anode control
    output wire [6:0] seg,          // segs
    output wire dp                  // dp
);
    wire up_down_top;
    wire div_w;
    wire reset_top;
    wire in_two;
    wire [3:0]cont_w;
    
    // El orden del los displays toman en orden viceversa a como se asigna en el arreglo display_data[15:00].
    // display_data[15:12]	Display 1
    // display_data[11:8]	Display 2
    // display_data[7:4]	Display 3
    // display_data[3:0]	Display 4
    
    // Se habilita los datos de despliegue solo para el display 1 y los demás se habilitan en 0.
    wire [15:0] display_data = {cont_w[3:0], 4'b0000, 4'b0000, 4'b0000};

    display_multiplexer display_unit (
        .clk(clk),
        .rst(rst),
        .data(display_data),
        .dp_in(4'b0000), // Puntos decimales apagados para desplegar los datos puramente positivos
        .sel_dig(an),
        .seg(seg),
        .dp(dp)
    );

    counter25 m0(
    .reset(rst),
    .clk(clk),
    .div_clk(div_w)
    );
    
    counter4 m1(
    .reset(reset_top),
    .div_clk(div_w),
    .up_down(up_down_top),
    .cont(cont_w)
    );
    
    comparator m2(
    .cont(cont_w),
    .reset(in_two)
    );
    
    or_module m3(
    .in_one(rst),
    .in_two(in_two),
    .reset_out(reset_top)
    );
    
endmodule