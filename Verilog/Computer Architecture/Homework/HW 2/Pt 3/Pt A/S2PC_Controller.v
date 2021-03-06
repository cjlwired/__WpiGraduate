// Carlos Lazo
// ECE505
// Homework 02 - Pt3

// Controller for S2PC

`define idle 4'b0000
`define init 4'b0001
`define d1   4'b0010
`define d2   4'b0011
`define d3   4'b0100
`define d4   4'b0101
`define d5   4'b0110
`define d6   4'b0111
`define d7   4'b1000
`define d8   4'b1001

`timescale 1ns/100ps

module S2PC_Controller (input clk, start,
                        output reg done, ready, shift_en);

  // Initialize a register to keep track of the current state.

  reg [3:0] current;
  
  initial begin
    current = 0;
  end
  
  // Implement the combinational logic part of the Controller.
  
  always @ (current, start) begin
  
    done = 1; ready = 1; shift_en = 0;
    
    case (current)
      
      `idle: if (~start) begin
        done = 1; ready = 1; shift_en = 0;
      end
      
      `init: begin
        
        done = 1; ready = 1; shift_en = 0;
        
      end
      
      `d1, `d2, `d3, `d4, `d5, `d6, `d7, `d8: begin
        
        done = 0; ready = 0; shift_en = 1;
        
      end
      
    endcase
    
  end
  
  // Implement the sequential logic part of the Controller.
  
  always @ (posedge clk) begin
    
    case (current)
      
      // While start = 0, remain in the idle state.
      
      `idle : current <= ~start ? `idle : `init;
      
      // Once a clk pulse is seen on start, remain in init state
      // until the clk pulse is done (start = 0).
      
      `init : current <=  start ? `init : `d1;

      // Increment through the first 7 different states of data collection.

      `d1, `d2, `d3, `d4, `d5, `d6, `d7:
              current <= current + 1;
      
      // Once you reach the 8th clk of data collection, enable signals and
      // reset back to the `idle state.
              
      `d8 : current <= `idle;
      
    endcase
    
  end
      
endmodule