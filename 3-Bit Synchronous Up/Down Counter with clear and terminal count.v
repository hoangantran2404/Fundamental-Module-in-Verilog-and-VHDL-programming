//Verilog: Structural Desscrition of a 3-Bit Synchronous Up/Down Counter with clear and terminal count.
//If Dir =0, the counter counts down; if Dir =1,the counter counts up.
//up_down_counter_3bit uses to link 3 flip-flop JK to activate on the same rising edge of the clock.

/*tc will announce when the counter reaches its maximum value (111 in binary) 
when counting up or its minimum value (000 in binary) when counting down and will start a new process*/
module up_down_counter_3bit(clk, clrbar, Dir, q, qbar, tc); 
    input clk, clrbar, Dir;
    output wire [2:0] q, qbar;
    output wire tc;

    wire clr, dirbar;
    not(clrbar,clr);      // clr = active high clear
    not(dirbar,dir);       // Dir = 1 up, Dir = 0 down

    // Internal control signals
    wire j0, j1, j2;
    wire k0, k1, k2;

    // Bit 0 - toggle on every clk if clrbar active
    assign j0 = 1'b1;
    assign k0 = 1'b1;

    // Bit 1 - toggle when q[0] is 1 (up), or q[0] is 0 (down)
    //If dir =0 -> down and q0=0 => toggle
    //If dir =1 -> up and q0=1 => toggle
    //FF1
    wire q0_down, q0_up;
    assign q0_down = ~q[0] & dirbar;
    assign q0_up   = q[0] & Dir;
    assign j1 = (q0_up | q0_down) & clrbar;// clrbar =1 to enable counting
    assign k1 = j1; // Same condition

    // Bit 2 - toggle when q[1] & q[0] = 1 (up) or both are 0 (down)
    //FF2 will toogle when q1=q0=dir=1(UP) or q1=q0=dir=0(DOWN) and clrbar=1(NOT clear);
    wire q01_down, q01_up;
    assign q01_down = ~(q[1] | q[0]) & dirbar; // q1=0, q0=0
    assign q01_up   = q[1] & q[0] & Dir;
    assign j2 = (q01_up | q01_down) & clrbar;
    assign k2 = j2;

    // Instantiate 3 JK flip-flops
    JK_FF M0(.J(j0), .K(k0), .clk(clk), .clr(clr), .Q(q[0]), .Qbar(qbar[0]));
    JK_FF M1(.J(j1), .K(k1), .clk(clk), .clr(clr), .Q(q[1]), .Qbar(qbar[1]));
    JK_FF M2(.J(j2), .K(k2), .clk(clk), .clr(clr), .Q(q[2]), .Qbar(qbar[2]));

    // Terminal Count: tc = 111 when counting up, or 000 when counting down
    assign tc = (Dir && (q == 3'b111)) || (!Dir && (q == 3'b000));// tc=1 when counter reaches 111 in up mode or 000 in down mode
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
    D_latch master(.D(D), .E(clkb), .clr(clr), .Q(Qm), .Qbar(Qmb));
    D_latch slave (.D(Qm), .E(clk),  .clr(clr), .Q(Q),  .Qbar(Qbar));
    endmodule
module D_latch(D, E, clr, Q, Qbar);
    input D, E, clr;
    output reg Q, Qbar;    
    always @(*) begin
        if (!clr)// clear =0 -> reset
            Q = 0;
        else 
            if (E)// clear =1 and Enable =1 
            Q = D; 
        Qbar = ~Q;
    end
    endmodule
