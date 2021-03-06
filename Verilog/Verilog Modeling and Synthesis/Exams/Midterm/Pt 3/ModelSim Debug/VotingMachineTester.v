// Carlos Lazo
// ECE574
// Test 1

// Tester

`timescale 1ns/100ps

module VotingMachineTester;
  
  reg [7:0] data;

	
	initial begin
	  
	  clk = 0;
	  rst = 0;
	  
	  data = 8'b00000000;
	  
	end
	
	initial begin
	  
	  rst <= #5 1;
	  
	  data <= #25  8'b01000000;
	  data <= #45  8'b00001000;
	  data <= #65  8'b00100000;
	  data <= #85  8'b00100000;
	  data <= #105 8'b01000000;
	  data <= #125 8'b10000000;
	  data <= #145 8'b10000000;
	  data <= #165 8'b00100000;
	end
	  
	initial repeat (100) #10 clk = ~clk;
	   
endmodule