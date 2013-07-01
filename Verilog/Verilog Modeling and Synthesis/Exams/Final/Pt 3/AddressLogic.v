// Carlos Lazo
// ECE574
// Test 2

// FIR Filter - AddressLogic Implementation

`timescale 1ns/100ps

module AddressLogic (
	PCside ALout, ResetPC, PCplusI, PCplus1, RplusI, Rplus0
);
input [15:0] PCside;
input ResetPC, PCplusI, PCplus1, RplusI, Rplus0;
output [15:0] ALout;
reg [15:0] ALout;

// Removed unecessary inputs based on FIR Filter design.

	always @(PCside or ResetPC or PCplusI or PCplus1 or RplusI or Rplus0)
		case ({ResetPC, PCplusI, PCplus1, RplusI, Rplus0})
			5'b10000: ALout = 0;
			5'b01000: ALout = PCside + Iside;
			5'b00100: ALout = PCside + 1;
			5'b00010: ALout = Rside + Iside;
			5'b00001: ALout = Rside;
			default: ALout = PCside;
		endcase

endmodule