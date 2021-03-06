// Carlos Lazo
// ECE505
// Homework 04

// Controller of 16-bit Booth Multiplier

`define Idle   2'b00
`define Init   2'b01
`define Count  2'b10

`timescale 1ns/100ps

module Controller (
    input busy, clk, start,
    output reg done, en_CNT, ld_M, ld_Q, rst_A, rst_Count, rst_Qr); 
  
  // Define state variable:
  
  reg [1:0] current = 2'b0;      
  
  // Implement all Controller logic and set all appropriate signals:
  
  always @ (posedge clk) begin

    // Initialize all signals to 0 to prevent latches:
    
    done = 0; en_CNT = 0; ld_M = 0; ld_Q = 0; rst_A = 0;
    rst_Count = 0; rst_Qr = 0;
    
    case (current)
      
      // If in the Idle state, continue to stay here until start = 1;
      
      `Idle: begin
        
        done = 1;
        
        if (start) current <= `Init;
        else       current <= `Idle;
          
      end
          
      `Init: begin
        
        // Initialize all registers with the current input,
        // and reset all other registers/counters accordingly.
        
        done = 0; en_CNT = 0; ld_M = 1; ld_Q = 1; rst_A = 1;
        rst_Count = 1; rst_Qr = 1;
        
        #1;
        
        current <= `Count;
        
      end
      
      // Enable the counter, which also enables the ALU operation
      // in the Datapath. Perform operation until multiplication is done.
      
      `Count: begin
        
        #1;
        
        done = 0; en_CNT = 1;
        
        #1;
        
        if (busy)
          current <= `Count;
        else
          current <= `Idle;
          
      end
      
      default: current <= `Idle;          
      
    endcase
    
  end
  
endmodule