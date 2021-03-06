`timescale 1ns/100ps

module MooreDetector1101Tester;
  
  reg aa, clock, rst;
  wire ww;
  
  MooreDetector1101 UUT (aa, clock, rst, ww);
  
  initial begin
    aa = 0; clock = 0; rst = 1;
  end
  
  initial repeat (47) #7 clock = ~clock;
  initial repeat (15) #23 aa = ~aa;
  initial begin
    #31 rst = 1;
    #23 rst = 0;
  end
  
  always @(ww) if (ww == 1)
    $display ("A 1 was detected on w at time = %t", $time);
    
endmodule