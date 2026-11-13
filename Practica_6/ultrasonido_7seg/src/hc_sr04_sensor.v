`timescale 1ns / 1ps
module hc_sr04_sensor (
    input clk,
    input rst,
    input measure,
    input echo,
    output reg trig,
    output ready,
    output reg [9:0] distance_cm
);
    localparam IDLE       = 2'b00, 
               TRIGGER    = 2'b01, 
               WAIT_ECHO  = 2'b11, 
               COUNT_ECHO = 2'b10;

    reg [1:0] state;
    reg [8:0] trig_counter; 
    reg [10:0] cm_counter;  
    
    reg [9:0] temp_distance; 

    assign ready = (state == IDLE);

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state <= IDLE;
            trig <= 0;
            trig_counter <= 0;
            cm_counter <= 0;
            distance_cm <= 0;
            temp_distance <= 0;
        end else begin
            case (state)
                IDLE: begin
                    trig <= 0;
                    if (measure) begin
                        state <= TRIGGER;
                        trig_counter <= 0;
                        temp_distance <= 0;
                    end
                end
                TRIGGER: begin
                    trig <= 1;
                    if (trig_counter == 9'd270) begin 
                        state <= WAIT_ECHO;
                        trig <= 0;
                    end else begin
                        trig_counter <= trig_counter + 1;
                    end
                end
                WAIT_ECHO: begin
                    cm_counter <= 0;
                    if (echo) state <= COUNT_ECHO;
                end
                COUNT_ECHO: begin
                    if (echo) begin
                        if (cm_counter == 11'd1565) begin 
                            cm_counter <= 0;
                            temp_distance <= temp_distance + 1; 
                        end else begin
                            cm_counter <= cm_counter + 1;
                        end
                    end else begin
                        distance_cm <= temp_distance; 
                        state <= IDLE;
                    end
                end
            endcase
        end
    end
endmodule