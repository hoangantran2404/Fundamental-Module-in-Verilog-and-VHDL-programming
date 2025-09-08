// Latches are sequential circuits.
// The present value of Qn is called the current state when enable (E) is inactive.
// The present value of Qn is called the next state(Q(n+1)) when enable (E) is active.
// The truth table of D_Latch    (x is don't care)
// E D    Q(n)  Q(n+1)
// 0 x    0      0
// 0 x    1      1
// 1 0    x      0
// 1 1    x      1
// Based on the truth table, we can conclude when enable(E)=0, Q(n+1)=Qn. And when enable(E)=1, Q(n+1)= input(D).
// -> Boolean function Q= (~E&Q)|(E&D);

module D_Latch(input D,E,
               output Q,Qbar);
wire c1, c2;
  and(c1,D,E);
  not(Ebar,E);
  and(c2,Ebar,Q);
  nor(Qbar,c1,c2);
  not(Q,Qbar);
  // Or we can write ONLY this statement: assign Q=(~E&Q)|(E&D);
  
endmodule 
