// Carlos Lazo
// ECE574
// Homework #2

// This file is the blocking file provided for Part 1.

`timescale 1ns/100ps
	
	module HW2Pt1 (input clk, input [7:0] iNB, iB,
				 output reg [7:0] aNB, bNB, aB, bB);
				 
	always @(posedge clk) begin
		aNB <= iNB;
		bNB <= aNB;
	end
	
	always @(posedge clk) begin
		aB = iB;
		bB = aB;
	end
	
endmodule