// Verilog SRAM Memory Cell Description
module SRAM_memory(sel, RW, Din, o1);
  input sel, RW, Din;
  output o1;

  wire RWb, Dinb;
  wire s, r;
  wire Q, Qbar;
  wire S1;

  not (RWb, RW);
  not (Dinb, Din);

  and (s, sel, RWb, Din);
  and (r, sel, RWb, Dinb);

  SR_latch SR1(r, s, Q, Qbar);

  and (S1, sel, RW, Q);
  or  (o1, S1, s);
    endmodule
module SR_latch(input R, S, output Q, Qbar);
  nor(Q, R, Qbar);
  nor(Qbar, S, Q);
    endmodule
