`timescale 1ns/100ps

module MealyDetector1101 (input A, clk, R, output W);
  
  parameter [1:0] sA = 2'b00, sB = 2'b01, sC = 2'b10, sD = 2'b11;
  reg [1:0] current;
  
  always @(posedge clk) begin
    
    if (R) current <= sA;
    else
      
      case (current) 
        sA: if (A) current <= sB; else current <= sA;
        sB: if (A) current <= sC; else current <= sA;
        sC: if (A) current <= sC; else current <= sD;
        sD: if (A) current <= sB; else current <= sA;
      endcase
      
  end
 
  assign W = (current == sD && A == 1'b1) ? 1'b1 : 1'b0;
  
endmodule