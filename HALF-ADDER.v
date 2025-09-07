// Half-Adder module is the most basic arithmetic circuit used to add two binary bits. 
//It is the foundation for designing more complex adder circuits such as Full Adder, Ripple-Carry Adder, Carry Look-Ahead Adder, etc.

module HALF_ADDER(input a,b
                  output sum,cout);
//cout = carry_out
  xor (sum,a,b);
// assign sum= a^b;
  and(cout,a,b);
// assign cout=a&b;

endmodule
