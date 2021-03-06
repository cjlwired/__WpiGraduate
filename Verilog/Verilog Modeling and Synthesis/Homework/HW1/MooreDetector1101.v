`timescale 1ns/100ps

module MooreDetector1101 (input A, clk, R, output W);
  
  parameter [2:0] sA = 3'b000, sB = 3'b001, sC = 3'b010, sD = 3'b011, sE = 3'b100;
  reg [2:0] current;
  
  always @(posedge clk) begin
    
    if (R) current <= sA;
    else
      
      case (current) 
        sA: if (A) current <= sB; else current <= sA;
        sB: if (A) current <= sC; else current <= sA;
        sC: if (A) current <= sC; else current <= sD;
        sD: if (A) current <= sE; else current <= sA;
        sE: if (A) current <= sC; else current <= sA;
      endcase
      
  end
 
  assign W = (current == sE) ? 1 : 0;
  
endmodule