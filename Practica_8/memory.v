`timescale 1ns / 1ps
module memory(address, data);
    input [5:0]address;
    output reg [9:0] data;

    // Configuracion 8N1 (LSB sale primero por tx)
    localparam STOP_BIT = 1'b1;
    localparam START_BIT = 1'b0;
    
    reg [7:0] payload;
    
    // mensaje = "Guillermo Zalapa, Practica 8 - Comunicacion UART - HC-05";
    // 47 75 69 6C 6C 65 72 6D 6F 20 5A 61 6C 61 70 61 2C 20 50 72 61 63 74 69 63 61 20 38 20 2D 20 43 6F 6D 75 6E 69 63 61 63 69 6F 6E 20 55 41 52 54 20 2D 20 48 43 2D 30 35 5C 6E
    localparam [0:463] mensaje = {
        8'h47, 8'h75, 8'h69, 8'h6C, 8'h6C, 8'h65, 8'h72, 8'h6D, 8'h6F, 8'h20,
        8'h5A, 8'h61, 8'h6C, 8'h61, 8'h70, 8'h61, 8'h2C, 8'h20, 8'h50, 8'h72,
        8'h61, 8'h63, 8'h74, 8'h69, 8'h63, 8'h61, 8'h20, 8'h38, 8'h20, 8'h2D,
        8'h20, 8'h43, 8'h6F, 8'h6D, 8'h75, 8'h6E, 8'h69, 8'h63, 8'h61, 8'h63,
        8'h69, 8'h6F, 8'h6E, 8'h20, 8'h55, 8'h41, 8'h52, 8'h54, 8'h20, 8'h2D,
        8'h20, 8'h48, 8'h43, 8'h2D, 8'h30, 8'h35, 8'h5C, 8'h6E
    };

    always @ (address) begin
        if (address < 6'd58) begin
            payload = mensaje[address * 8 +: 8];
            data = {STOP_BIT, payload, START_BIT};
        end else begin
            payload = 8'hFF;
            data = 10'b1111111111; // Linea en IDLE (1) al terminar el mensaje
        end
    end
    // always @ (adres) begin
    //     case (adres)
    //         0 : paylxoad = 8'h48; //H
    //         1 : payload = 8'h4F; //O
    //         2 : payload = 8'h4C; //L
    //         3 : payload = 8'h41; //A
    //         4 : payload = 8'h20; //ESPACIO
    //         5 : payload = 8'h4D; //M
    //         6 : payload = 8'h55; //U
    //         7 : payload = 8'h4E; //N
    //         8 : payload = 8'h44; //D
    //         9 : payload = 8'h4F; //O
    //         10 : payload = 8'h0A; ////salto de linea 
    //         default: payload = 8'bFF;
    //     endcase
    //     data = {IDLE_START, payload, PAR_STOP};
    // end
endmodule
