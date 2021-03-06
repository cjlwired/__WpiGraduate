// Carlos Lazo
// ECE574
// Test 1

// Part 2: Arithmtic Logic Unit (ALU)
// Part C: 16-bit Cascadable ALU Max Delay

module ALU16bitTimeTest;
  
  // Declare all inputs as reg and outputs as wire:
  
  reg [15:0] A, B;
  reg  [1:0] S;
  reg Ci;
  
  wire [15:0] R;
  wire Co, V, Z;
  
  // Instantiate a FullAdder:
  
  ALU16bit UUT (A, B, S, Ci, R, Co, V, Z);
  
  initial begin
    
    A = 16'b0000000000000000;
    B = 16'b0000000000000000;
    S = 2'b00; Ci = 0;
    
  end
  
  // Create the testbench sequence, showing expected results.
  
  initial begin

    #0;

    // Worst case timing scenario -

    // Set  A = 0000000011111111
    // Set  B = 1111111100000000
    // Set Ci = 1
    
    // R = 0000000000000000, Co = 1, V = 0, Z = 1.

    A  <= 16'b0000000011111111;
    B  <= 16'b1111111100000000;
    S  <= 2'b00;
    Ci <= 1;
    
    #250;
    
  end
  
endmodule