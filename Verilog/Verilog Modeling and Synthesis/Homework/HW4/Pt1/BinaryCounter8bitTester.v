// Carlos Lazo
// ECE574
// Homework #4

// Part 1: Binary Counter, 8 bit testbench implementation.

`timescale 1ns/100ps

module BinaryCounter8bitTester;
  
  // Define a parameter so that the adder can be any size:
  
  parameter SIZE = 8;
   
  // Declare all inputs as reg and outputs as wire:
  
  reg  clk, rst, init, cin;
  wire cout;
  
  // Instantiate a FullAdder4bit:
  
  BinaryCounter8bit UUT (clk, rst, init, cin, cout);
  
  // Set clock to start at 0 and all other inputs accordingly.
                    
  initial begin
    clk = 0; rst = 0; init = 0; cin = 1;
    
    #15 rst = 1;
  end
  
  // Repeat the clock for a total of 150 cycles.
  
  initial repeat (300) #10 clk = ~clk;
  
  
endmodule