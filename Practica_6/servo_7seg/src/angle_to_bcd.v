module angle_to_bcd 
    #(
    parameter SERVO_STEPS = 64,
    parameter MAX_ANGLE = 180
    )(duty, display_out);
    input wire [5:0] duty;
    output wire [15:0] display_out;

    wire [13:0] mult_result = duty * MAX_ANGLE;
    wire [7:0] angle_bin = mult_result/ SERVO_STEPS;
    
    reg [3:0] centenas;
    reg [3:0] decenas;
    reg [3:0] unidades;
    reg [7:0] temp;
    
    always @(*) begin
        if (angle_bin >= 8'd100) begin
            centenas = 4'd1;
            temp = angle_bin - 8'd100;
        end else begin
            centenas = 4'd0;
            temp = angle_bin;
        end
        if (temp >= 90) begin decenas = 4'd9; unidades = temp - 8'd90; end
        else if (temp >= 80) begin decenas = 4'd8; unidades = temp - 8'd80; end
        else if (temp >= 70) begin decenas = 4'd7; unidades = temp - 8'd70; end
        else if (temp >= 60) begin decenas = 4'd6; unidades = temp - 8'd60; end
        else if (temp >= 50) begin decenas = 4'd5; unidades = temp - 8'd50; end
        else if (temp >= 40) begin decenas = 4'd4; unidades = temp - 8'd40; end
        else if (temp >= 30) begin decenas = 4'd3; unidades = temp - 8'd30; end
        else if (temp >= 20) begin decenas = 4'd2; unidades = temp - 8'd20; end
        else if (temp >= 10) begin decenas = 4'd1; unidades = temp - 8'd10; end
        else begin decenas = 4'd0; unidades = temp[3:0]; end
    end
    assign display_out = {unidades, decenas, centenas, 4'b00};
endmodule
