module three_bit_comparator(x,y,xgty,xlty,xeqy);
    input [2:0] x,y;
    output reg xgty,xlty,xeqy;
    wire [2:0] carry;
    wire [2:0] sum,ybar;
        not(ybar[0],y[0]);
        not(ybar[1],y[1]);
        not(ybar[2],y[2]);
        Full_adder M0(x[0],ybar[0],1'b0,sum[0],carry[0]);
        Full_adder M1(x[1],ybar[1],carry[0],sum[1],carry[1]);
        Full_adder M2(x[2],ybar[2],carry[1],sum[2],xgty);

        and(xeqy,sum0,sum1,sum2);
        nor(xlty,xeqy,xgty);
    endmodule
module Full_adder(a,b,cin,sum,cout);
    input a,b,cin;
    output sum,cout;
        wire s0,c0,c1;
        Half_adder HA0(s0,c0,b,cin);
        Half_adder HA1(sum,c1,a,s0);
        or(cout,c0,c1);
    endmodule
module Half_adder(s,c,a,b);
    input a,b;
    output s,c;
        xor(s,a,b);
    and(c,a,b);
    endmodule
