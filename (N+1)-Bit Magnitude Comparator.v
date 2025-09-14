// Verilog: Structural Description of (N+1)-Bit Magnitude Comparator by using Generate statement
module magnitude_comparator (x,y,xgty,xlty,xeqy);
    parameter N=3;
    input [N:0] x,y;
    output reg xgty,xlty,xeqy;
    //internal signals 
    wire [N:0] xeqy_bit,gt_bit,lt_bit;
    wire [N+1:0] equal_chain; 

    assign equal_chain[0]=1'b1; //LSB is always equal
    genvar i;
    generate
        //compare the current bits of x and y
        for(i=0;i<=N;i=i+1) begin
            xnor (xeqy_bit[i], x[i],y[i]);// It will be 1 if x=y=0 or x=y=1
            and  (gt_bit[i],x[i],~y[i]);// It will be 1 only if x=~y=1-> y=0
            and  (lt_bit[i],~x[i],y[i]);// It will be 1 only if ~x=y=1-> x=0
            // equal_chain[i+1] =1 when equal_chain[i]=1, meaning all previous bits of x and y are equal.
            // and xeqy_bit[i]=1, meaning the current bits of x and y are equal. 
            and  (equal_chain[i+1],equal_chain[i],xeqy_bit[i]);
        end
    endgenerate
    for (i=0;i<=N;i=i+1) begin
        //gt_term[i]=1 if gt_bit[i]=1 and all previous bits of x and y are equal
        and (gt_term[i],gt_bit[i],equal_chain[i]);
        //lt_term[i]=1 if lt_bit[i]=1 and all previous bits of x and y are equal
        and (lt_term[i],lt_bit[i],equal_chain[i]);
    end

    //Conclude the final results
    //xgty =1 if gt_term[i]=1,gt_term[2] =1,gt_term[3]=1,.......gt_term[N]=1
        assign xgty=|gt_term;
    //xlty =1 if lt_term[i]=1,lt_term[2] =1,lt_term[3]=1,.......lt_term[N]=1
        assign xlty=|lt_term;
    //xeqy =1 if equal_chain[N+1]=1, meaning all bits of x and y are equal
        assign xeqy=equal_chain[N+1];
    endmodule
