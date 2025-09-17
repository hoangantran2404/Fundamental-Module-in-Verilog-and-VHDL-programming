//Booth: Signed Vector Multiplication
module booth_sig_vect_multip(a0,a1,a2,b0,b1,b2,Z);
parameter N=4;
input signed [N-1:0]a0,a1,a2,b0,b1,b2;// a is multiplicand, b is multiplier
output signed [3*N:0] Z;
// Internal wires
reg signed [2*N:0] tem0, tem1, tem2;
reg signed [3*N:0] d;
assign Z=d;

always @(*) begin
booth(a0,b0,tem0);
booth(a1,b1,tem1);
booth(a2,b2,tem2);
d = tem0+tem1+tem2;
end
task booth;
input signed[N-1:0] multiplicand,multiplier;
output signed [2*N:0] product;

reg signed [N:0] A,S;
reg signed [2*N:0] P;
integer i;
always @(multiplicand, multiplier) begin
    A = {multiplicand, {N{1'b0}}}; // A= multiplicand <<N
    S = {-multiplicand,{N{1'b0}}}; // S=-multiplicand <<N
    P ={{N{1'b0}},multiplier,1'b0};//P = {0s, multiplier, Q-1}

    for(i=0; i<N;i=i+1) begin
        case(P[1:0])
            2'b10: P=P+S;  
            2'b01: P=P+A;
        default: ;// Do nothing for 00 or 11
        endcase
        // This is arithm shif-right, means shift all bit-1 to the right
        // For example,we have P=110101010(before)
        // We have to keep the same signed of P(sign-preserving), which is negative (=1) so the P =111010101(after)
        P= $signed(P) >>> 1;

    end
    //This means [P[2*N:N+1]]   [P[N:1]]         [P[0]]
    //...........Accumularot..Multiplier ...Q-1(extra bit)
    //Drop Q-1 bit because it is the extra Q-1 bit
    product =P[2*N:1];// Includes sign(2's complement result)
    end

endtask

endmodule
// Example:
// Multiplicand (M): 3 =0011;
// Multiplier (Q): 2 =0010;
//Expected result: 3*2=6 = 00000110;
// After 4 cycles, I get P=00001100
// To get expected result, I need to remove the Q-1 (0);
