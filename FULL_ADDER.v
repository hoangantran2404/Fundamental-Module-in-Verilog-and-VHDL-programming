// Basic structure of FULL ADDER 
module FULL_ADDER(x,y,D,sum,cout);//cout means carry-out
input x,y,D;
output sum,cout;
wire s0,c1,c0;
  HALF_ADDER HA1(.sum_ha(s0),.cout_ha(c0),.a(y),.b(D));
  HALF_ADDER HA2(.sum_ha(sum),.cout_ha(c1),.a(x),.b(s0));
  or(cout,c0,c1);
endmodule

module HALF_ADDER (a,b,sum_ha,cout_ha);
input a,b;
output sum_ha,cout_ha;
  xor(sum_ha,a,b);
  and(cout_ha,a,b);
endmodule 
