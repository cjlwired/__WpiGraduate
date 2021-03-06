// Carlos Lazo
// ECE574
// Homework #7

// Part 1: Transistor-Level Circuit Implementation

`timescale 1ns/100ps

module transistorCircuit (input a, b, c, d, output y);
  
  // All complements of inputs are available.
  
  wire _a, _b, _c, _d;
  wire im1, im2, im3;
  wire f1, f2, f3;
  
  not (_a, a), (_b, b), (_c, c),(_d, d);
  
  supply0 Gnd;
  supply1 Vdd;
  
  // Function that needs to be represented is the following:
  // f(a,b,c,d) = a'b + ac + c'd'
  
  // In order to minimize, notice that you can use DeMorgan's Law
  // to rewrite the functions in terms of NOR:
  // f(a,b,c,d) = (a + b')' + (a' + c')' + (c + d)'
  
  // First, compute all 3 individual AND groups.
  
    // Group #1 = a'b = (a + b')' --- (NOR)
    
  pmos #(4,5,6) f1_p1 (im1,  Vdd,  a),
                f1_p2 (f1, im1, _b);
  nmos #(3,4,5) f1_n1 (f1, Gnd,  a),
                f1_n2 (f1, Gnd, _b);
                
    // Group #2 = ac = (a' + c')'
    
  pmos #(4,5,6) f2_p1 (im2,  Vdd, _a),
                f2_p2 (f2, im2, _c);
  nmos #(3,4,5) f2_n1 (f2, Gnd, _a),
                f2_n2 (f2, Gnd, _c);
  
      // Group #3 = c'd' = (c + d)'
  
  pmos #(4,5,6) f3_p1 (im3,  Vdd, c),
                f3_p2 (f3, im3, d);
  nmos #(3,4,5) f3_n1 (f3, Gnd, c),
                f3_n2 (f3, Gnd, d);
  
  // Now, OR the three AND outputs.
  // Cascade the first two, then that result with the third.
  
  wire imo1, imo2, outf1, outf2, f1_2;
  
    // Group #1 = a'b + ac --- (NOR > Invert)
  
  pmos #(4,5,6) o1_p1 (imo1,   Vdd, f1),
                o1_p2 (outf1, imo1, f2);
                
  nmos #(3,4,5) o1_n1 (outf1, Gnd, f1),
                o1_n2 (outf1, Gnd, f2);
                
  pmos #(4,5,6) o1_pf (f1_2, Vdd, outf1);
  nmos #(3,4,5) o1_nf (f1_2, Gnd, outf1);
  
    // Group #2 = (a'b + ac) + c'd' --- (NOR > Invert)
  
  pmos #(4,5,6) o2_p1 (imo2,   Vdd, f1_2),
                o2_p2 (outf2, imo2, f3);
                
  nmos #(3,4,5) o2_n1 (outf2, Gnd, f1_2),
                o2_n2 (outf2, Gnd, f3);
                
  pmos #(4,5,6) o2_pf (y, Vdd, outf2);
  nmos #(3,4,5) o2_nf (y, Gnd, outf2);
  
endmodule