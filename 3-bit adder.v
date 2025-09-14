//3-bit adder using structural modeling
//Cấu tạo của bộ cộng ripple carry 3-bit:

    /*Bộ cộng ripple carry 3-bit bao gồm 3 bộ cộng toàn phần (full adders), mỗi bộ cộng toàn phần thực hiện phép cộng cho một cặp bit tại cùng vị trí và bit nhớ từ vị trí thấp hơn.
        Cấu trúc như sau:
            A2   A1   A0   (số thứ nhất - 3 bit)
        + B2 + B1 + B0   (số thứ hai - 3 bit)
        ------------------
            S2   S1   S0   (kết quả - 3 bit)
                + Cout     (bit nhớ ra)
        Trong đó:
        A0, A1, A2: Các bit của số A (bit A0 là thấp nhất - LSB)
        B0, B1, B2: Các bit của số B (bit B0 là thấp nhất)
        S0, S1, S2: Các bit của tổng
        Cout: Bit nhớ ra cuối cùng
        ⚙️ Nguyên lý hoạt động:
                Full Adder 0:
                Inputs: A0, B0, Carry_in = 0 (không có bit nhớ trước đó)
                Outputs: S0, Carry0

                Full Adder 1:
                Inputs: A1, B1, Carry_in = Carry0
                Outputs: S1, Carry1

                Full Adder 2:
                Inputs: A2, B2, Carry_in = Carry1
                Outputs: S2, Carry_out (Cout)
        Bit nhớ "ripple" (dồn) từ FA0 sang FA1, rồi đến FA2 — vì vậy gọi là ripple carry.*/
module three_bit_adder(x,y,cin,sum,cout);
    input [2:0] x,y;
    input cin;
    output [2:0] sum;
    output cout;
        wire [1:0]carry;
        Full_adder Module1(x[0],y[0],cin,sum[0],carry[0]);
        Full_adder Module2(x[1],y[1],carry[0],sum[1],carry[1]);
        Full_adder Module3(x[2],y[2],carry[1],sum[2],cout);
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
