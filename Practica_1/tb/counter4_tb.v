`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////
module counter4_tb();
    reg div_clk;
    reg clear;
    wire [3:0] cont;
    
    // 1. Variables para el self-check
    reg [3:0] expected_cont;
    integer error_count;
    
    // Instanciación del Device Under Test (DUT)
    counter4 dut(
        .div_clk(div_clk), 
        .clear(clear), 
        .cont(cont)
    );
    
    initial begin
        // Inicialización
        div_clk = 1'b0;
        clear = 1'b0;
        error_count = 0;
        expected_cont = 4'd0;
        
        #37;
        clear = 1'b1; // Activa el reset
        #37;
        clear = 1'b0; // Desactiva el reset, comienza a contar

        #2000;
        
        $display("---------------------------------------------------");
        if (error_count == 0)
            $display(">>> SIMULACION EXITOSA: 0 errores encontrados. <<<");
        else
            $display(">>> SIMULACION FALLIDA: %0d errores encontrados. <<<", error_count);
        $display("---------------------------------------------------");
        
        $finish;
    end
    
    always #18.5 div_clk = ~div_clk; 

    always @(posedge div_clk) begin
        if (clear) begin
            expected_cont <= 4'd0;
        end else begin
            if (expected_cont == 4'd15)
                expected_cont <= 4'd0;
            else
                expected_cont <= expected_cont + 1'b1;
        end
    end
    integer cc_dut = 0;
    
    always @(negedge div_clk) begin
        if ($time > 74) begin
            if (cont !== expected_cont) begin
                $display("[ERROR] Tiempo: %0t | Salida DUT: %d | Esperado: %d", $time, cont, expected_cont);
                error_count = error_count + 1;
            end
            else if (cc_dut < 20) begin 
                $display("[DEBUG] Tiempo: %0t | Salida DUT: %d | Esperado: %d", $time, cont, expected_cont);
                cc_dut = cc_dut + 1;
            end
        end
    end

endmodule