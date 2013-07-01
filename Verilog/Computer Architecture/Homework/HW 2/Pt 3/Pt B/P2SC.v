// Carlos Lazo
// ECE505
// Homework 02 - Pt3

// P2SC Module

`timescale 1ns/100ps

module P2SC (input [7:0] p_in,
             input clk, start,
             output sout, ready);
  
  // Use wires to store all outputs from the Controller:
  
  wire [2:0] addr;
  wire       ld_reg, out_en;
  
  
  P2SC_Datapath   dp (p_in, addr,clk, ld_reg, out_en, sout);
                      
  P2SC_Controller cu (clk, start, addr, ld_reg, out_en, ready);
  
endmodule