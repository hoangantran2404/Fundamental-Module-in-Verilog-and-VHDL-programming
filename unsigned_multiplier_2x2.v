
// 2x2 Unsigned Combinational Array Multiplier
// Multiplies 2-bit inputs x and y, outputs 4-bit product P
// Uses 4 AND gates and 2 Half Adders


module Unsigned_Multiplier_2x2 (input [1:0]x,y,
                                output [3:0] P);
  wire cout1;
  wire carry1,carry2,carry3;
  and (P[0],x[0],y[0]);
  and (carry1, x[1],y[0]);
  and(carry2,x[0],y[1]);
  and(carry3,x[1],y[1]);
  HA S1(carry1,carry2,P[1],cout1);
  HA S2(cout1,carry3,P[2],P[3]);
endmodule


module HALF_ADDER(input a,b, 
                  output s,c);
  xor(s,a,b);
  and(c,a,b);
endmodule
