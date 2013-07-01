// Carlos Lazo
// ECE574
// Homework #5

// Part 2: Finding smallest value in Memory

`timescale 1ns/100ps

module minMemValueTester;
  
  reg [7:0] data;
  reg       clk, start;
   
  wire [9:0]  rd_addr;
  wire [7:0]      out;
  wire          ready;
  
  reg [7:0] mem [0:1023];
  
  minMemValue UUT (clk, data, start, rd_addr, ready, out);
  
  // Initialize the memory.
  
  initial $readmemh("mem.dat", mem); 
  
  initial repeat (2500) #10 clk <= ~clk;
  
  always @(posedge clk) data = mem[rd_addr];
  
  initial begin
    
    clk   = 0;
    start = 0;
    
 	  start <= #10 1;
 	  start <= #20 0;
    
  end
  
endmodule