// This code uses booth algorithm.
// If you want to work with FPGA, should not apply this code because of complexity and delay time.
module vect_multiply(start,d);
parameter N=4;
parameter M=4;
input wire start;
//when two vector 4_bit multiple, the result might be 8-bit, but carefully take the 3*N to avoid overflow
output reg signed [3*M-1:0]d[N-1:0];
reg signed [M-1:0] a [0:N-1];
reg signed [M-1:0] b [0:N-1];
integer i;
      always @(*) begin
      a[0]=4'b1100;
      a[1]=4'b0000;
      a[2]=4'b1001;
      a[3]=4'b0011;
      a[4]=4'b1111;
      
      b[0]=4'b1010;
      b[1]=4'b0011;
      b[2]=4'b0111;
      b[3]=4'b1000;
      b[4]=4'b1000;
      d=0;
       for (i=0; i<N;i=i+1) 
       begin
          d[i]=booth_mul(a[i],b[i]);// Use fuction
       end
      end
function signed [3*M-1:0] booth_mul;
parameter H=4;
input [H-1:0] multiplier;
input [H-1:0] multiplicand;
output [3*H-1:0] product;

reg [H:0] A,S;
reg [2*H:0] P;
integer i;
    always @(multiplier, ,multiplicand) begin
        A={multiplicand,{H{1'b0}}};
        S={-multiplicand,{H{1'b0}}};
        P={{H{1'b0}},multiplier,1'b0};
            for (i=0;i<=N;i=i+1)
            begin
            case (P[1:0])begin
            2'b10: P=P+S;
            2'b01: P=P+A;
            default: ;
            end
            endcase
            P=$signed(P)>>>1; 
            end
            product = P[2*H:1];
    end
endfunction

endmodule
