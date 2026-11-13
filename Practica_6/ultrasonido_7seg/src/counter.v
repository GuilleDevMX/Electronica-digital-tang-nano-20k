`timescale 1ns / 1ps

module counter#(parameter ten_us = 1000)
                (clk, inIDLE, inTRIGGER, counter, trigcountDONE);
    input clk;
    input inIDLE;
    input inTRIGGER;
    
    output reg counter;
    output trigcountDONE;

  always@(posedge clk)
    begin
      if(inIDLE)
        begin
          counter <= 10'd0;
        end
      else
        begin
          counter <= counter + {9'd0, (|counter | inTRIGGER)};
        end
    end
  assign trigcountDONE = (counter == ten_us);
    
endmodule