// Carlos Lazo
// ECE574
// Homework #7

// Part 2: D Flip-Flop @ the Transistor-Level Testbench

`timescale 1ns/100ps

module DFlipFlopTester;

  // Define inputs and outputs:
  
  reg Clk, En, Rst, D;
  wire Q;
  
  DFlipFlop MUT (Clk, En, Rst, D, Q);
  
  initial begin
    
    Clk = 0;
    En  = 1;
    Rst = 1;
    D   = 0;
    
  end
  
  initial begin
    #50;
    Rst = 0;
  end
  
  initial begin
    #350;
    En = 0;
  end
  
  initial repeat (20) #20 Clk = ~Clk;
  
  initial begin
    // repeat (10) #30 D = $random;
    D <= #65  1;
    D <= #190 0;
    D <= #265 1;
    D <= #305 0;
    D <= #375 1;
  end
  
  
endmodule