// For example, we have a fraction binary(x_bi): 0,00101
// We will have x_bi[0]=0,x_bi[2]=1,x_bi[4]=1
// If we use result = result + 1/2**i -> The value of z is 2^(-2)+2^(-4) = 0.3125(WRONG)
// If we use result = result +1/2**(i+1) -> The value of z is 2^(-3)+2^(-5) =0.15625(CORRECT)
module conversion_fraction_binary_real(x_bi,z);
  parameter N=3;
  input reg [0:N] x_bi;
  output real z;

    always @(x_bi) begin
      fracbinary_to_real(x_bi,z);
    end

task fracbinary_to_real(bi_value,re_value);
  input [0:N] bi_value;
  output real re_value;

  integer i;
  real result;
  begin
    result=0.0;// should declare it first and remember don't put it in the for loop 
    for (i=0,i<=N,i=i+1) begin
      if(bi_value[i])
        result = result +1/(2**(i+1));
    end
    re_value = result;
  end
endtask

endmodule
