//Verilog: Structural Description of a 3-Bit Synchronous Counter with Active low Clear
// We need the CLEAR signal to reset the counter to 000 when it is low (0).
// When CLEAR is high (1), the counter operates normally, counting up on each clock pulse
// The counter counts from 000 to 111 (0 to 7 in decimal) and then rolls over back to 000.
// The counter uses JK flip-flops, where J and K are both tied to logic high (1'b1), making them toggle on each clock pulse when enabled.
// The counter is synchronous, meaning all flip-flops are triggered by the same clock edge.
// The counter has an active-low clear input (clrbar), which resets the counter to 000 when clrbar is low (0).

// You should remember that: 
// E(enable) can be clk in JK_FF or D_Flip_Flop but not in D_Latch.

module counter_3bit(clk, clrbar, q, qbar);
    input clk, clrbar;
    output wire [2:0] q, qbar;

    wire clr, clrb1;// Must declare internal signals 

    not(clr, clrbar);     // clr = !clrbar
    not(clrb1, clr);      // clrb1 = clrbar

    // FF0
    JK_FF M0(.J(1'b1), .K(1'b1), .clk(clk), .clr(clrb1), .Q(q[0]), .Qbar(qbar[0]));// Must write in this format to locate exactly the ports.

    // FF1
    wire j1, k1;
    and(j1, q[0], clrb1);
    and(k1, q[0], clr);
    JK_FF M1(.J(j1), .K(k1), .clk(clk), .clr(clrb1), .Q(q[1]), .Qbar(qbar[1]));

    // FF2
    wire j2, k2, a1;
    and(a1, q[1], q[0]);
    and(j2, a1, clrb1);
    or(k2, a1, clr);
    JK_FF M2(.J(j2), .K(k2), .clk(clk), .clr(clrb1), .Q(q[2]), .Qbar(qbar[2]));

    endmodule
module JK_FF(J, K, clk, clr, Q, Qbar);
    input J, K, clk, clr;
    output reg Q, Qbar;

    wire D, Kb, s1, s2;

    not(Kb, K);
    and(s1, J, Qbar);
    and(s2, Kb, Q);
    or(D, s1, s2);

    D_FF_master_slave D1(.D(D), .clk(clk), .clr(clr), .Q(Q), .Qbar(Qbar));
    endmodule
module D_FF_master_slave(D, clk, clr, Q, Qbar);
    input D, clk, clr;
    output Q, Qbar;

    wire clkb, Qm, Qmb;

    not(clkb, clk);
    // No need to invert clkb again to get clk2, just use clk directly for the slave latch.
    D_latch master(.D(D), .E(clkb), .clr(clr), .Q(Qm), .Qbar(Qmb));
    D_latch slave (.D(Qm), .E(clk),  .clr(clr), .Q(Q),  .Qbar(Qbar));
    endmodule
module D_latch(D, E, clr, Q, Qbar);

    // This modified exactly the behavior of D latch in the note.
    // If clear= 0-> reset Q=0
    // If clear =1 and Enable =1 => Q=D
    input D, E, clr;
    output reg Q, Qbar;

    always @(*) begin
        if (!clr)// clear =0 -> reset
            Q = 0;
        else 
            if (E)// clear =1 and Enable =1 
            Q = D; 
            //Don't write like the below: it will cause undefined behavior. With an empty, the computer knows nothing to do and keep the old value.
            //else 
            //Q = Q; // Enable =0 => hold the previous state
        Qbar = ~Q;
    end
    endmodule
