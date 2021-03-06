// Carlos Lazo
// ECE505
// Homework 02 - Pt3

// Datapath for P2SC

`timescale 1ns/100ps

module P2SC_Datapath (input [7:0] p_in, input [2:0] addr,
                      input clk, ld_reg, out_en,
                      output sout);
  
  // Define registers and state variables:
  
  reg [7:0] Par_Reg;
  
  // Initialize registers to values of 0.
  
  initial begin
    Par_Reg = 0;
  end
  
  // Perform the shift operation iF shifting is enabled (for 8 clk pulses).

  always @ (posedge clk)
    if (ld_reg)
      Par_Reg <= p_in;
      
  assign sout = out_en ? Par_Reg[addr] : 1'bz;
      
endmodule