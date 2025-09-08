//This Verilog module implements a 2-bit magnitude comparator.

//### Function:
//It compares two 2-bit inputs `x` and `y`, and outputs three 1-bit signals:
//- `xgty`: HIGH when x > y
//- `xlty`: HIGH when x < y
//- `xeqy`: HIGH when x == y

//### Use case:
//This module is useful in digital systems where binary numbers need to be compared, such as sorting circuits, control logic, or arithmetic units.

// Note:
// x[1]~^y[1] is ~(x[1]^y[1]). I simlify it to remember easily.

// Instruction (we get x>y as an example)
// Step 1: Compare the most significant bits (MSB), x[1] and y[1].
//         - If x[1] > y[1], then x > y.
//         - If x[1] < y[1], then x < y.
//         - If x[1] == y[1], continue to step 2.

// Step 2: Compare the least significant bits (LSB), x[0] and y[0].
//         - If x[0] > y[0], then x > y.
//         - If x[0] < y[0], then x < y.
//         - If x[0] == y[0], then x == y.


module Magnitude_comparator_2_Bit (input [1:0] x,y,
                                   output xgty,xlty,xeqy);
// x>y
  assign xgty= (x[1] & ~y[1]) | (x[1] ~^ y[1] & x[0] & ~y[0]);
  // we can write xgty = (x[1]&~y[1]) | (x[0]&x[1]&~y[0]) | (x[0]&~y[1]&~y[0]);
// x<y
  assign xlty= (~x[1] & y[1])  | (x[1] ~^ y[1] & ~x[0] & y[0]);
  // we can write = (~x[1]&y[1]) | (~x[0]&~x[1]&y[0]) | (~x[0]&y[1]&y[0]);
// x=y
  assign xeqy =~( xgty | xlty) ;
endmodule
