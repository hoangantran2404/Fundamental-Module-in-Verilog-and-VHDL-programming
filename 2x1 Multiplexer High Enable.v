// The multiplexer selects between two 1-bit inputs (A and B) based on a select line (Sel) when the enable signal (En) is high.
//If En = 0, the output is forced to 0, regardless of the inputs or selection.
module Multiplexer_2x1(input a,b,select, enable,
                       output y);
  if (enable ==0)
    assign y=1'b0;
  else 
    begin
      if (select ==0)
        assign y=a;
      else 
        assign y=b;
    end 
endmodule
      
