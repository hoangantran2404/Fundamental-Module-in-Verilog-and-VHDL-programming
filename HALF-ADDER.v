

module HALF_ADDER(input a,b
                  output sum,cout);
//cout = carry_out
  xor (sum,a,b);
// assign sum= a^b;
  and(cout,a,b);
// assign cout=a&b;

endmodule
