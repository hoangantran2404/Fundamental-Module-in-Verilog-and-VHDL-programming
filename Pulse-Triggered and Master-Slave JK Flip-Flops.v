// Verilog Pulse-Triggered and Master-Slave JK Flip-Flops
//Pulse-Triggered JK Flop-Flop giống như một bộ trung gian
        //Clk =1 thì Q(output) theo D(input) và toàn bộ trạng thái, thay đổi của D sẽ được truyền hết cho Q trong xung clock.
        //Clk =0 thì đóng cổng, Q giữ nguyên trạng thái. 
//Master-Slave JK Flip-Flop gồm 2 Pulse-Triggered JK Flip-Flop mắc nối tiếp nhau
        //Khi clock =1 thì Master JK Flip-Flop hoạt động(ACTIVE), Slave JK Flip-Flop giữ nguyên trạng thái(INACTIVE).
        //Khi clock =0 thì Slave JK Flip-Flop hoạt động (ACTIVE), Master JK Flip-Flop giữ nguyên trạng thái(INACTIVE).
        //Clk =1, master mở cổng lữu trữ tạm thời giá trị D,slave đóng cổng lưu giữ giá trị cũ. 
        //Clk =0, master đóng cổng giữ giá trị tạm thời, slave mở cổng truyền giá trị tạm thời từ master sang Q.
//Master-Slave JK Flip-Flops includes master-slave D flip-flop
//D flip-flop includes 2 D latches connected in series.

//Master-Slave D-flipflop: https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.build-electronic-circuits.com%2Fd-flip-flop%2F&psig=AOvVaw2nS68iFwb64HPsGQkpJpdN&ust=1757880163041000&source=images&cd=vfe&opi=89978449&ved=0CBYQjRxqFwoTCNDgyofE1o8DFQAAAAAdAAAAABAE
//Master-Slave JK-flipflop: https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.build-electronic-circuits.com%2Fjk-flip-flop%2F&psig=AOvVaw0hVhdJjnC9Rdt53UroZ92F&ust=1757881928307000&source=images&cd=vfe&opi=89978449&ved=0CBYQjRxqFwoTCIixm9LK1o8DFQAAAAAdAAAAABAT
module JK_FF(J,K,clk,Q,Qbar);
    input J,K,clk;
    output reg Q,Qbar;
    wire s1,s2;

    and(s1,J,Qbar);
    and(s2,Kb,Q);
    or(DD,s1,s2);
    not(Qbar,Q);
    not(Kb,k);
    D_ffmaster D1(DD,clk,Q,Qbar);
    endmodule

module D_ffmaster(D,clk,Q,Qbar);
    input D,clk;
    output reg Q,Qbar;
    wire clkb,clk2,Q0,Qbar0;
    not (clkb,clk);
    not(clk2,clkb);
    D_latch D_master(D,clkb,Q0,Qb0);
    D_latch D_slave(D,clk2,Q,Qbar);
    endmodule

module D_latch(D,E,Q,Qbar);
    input D,E;
    output reg Q,Qbar;
    wire c1,c2;
    and(c1,D,E);
    and(c2,Ebar,Q);
    nor(Qbar,c1,c2);
    not(Ebar,E);
    not(Qbar,Q);
    endmodule
