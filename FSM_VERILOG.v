// FSM is defined as a finite state machine, it will change its state, which depends on THE CURRENT STATE AND THE INPUT
'define state0 2'b00
'define state1 2'b01
'define state2 2'b10
'define state3 2'b11

module FSM(A,clk,pres_st,Z);
    input A,clk;
    output [1:0] pres_st;
    output Z;
    reg Z;

    reg [1:0] present;
    reg [1:0] pres_st;

    initial begin
        pres_st=2'b00;
    end
    always @(posedge clk) begin
        case(pres_st)
        'state0:
        begin
            present = A? 'state1: 'state0;
            Z=        A? 1'b1:1'b0;
        end
        'state1:
        begin
            present = A? 'state2: 'state3;
            Z=1'b0;
        end
        'state2:
        begin
            present = A? 'state3: 'state0;
            Z=1'b0;
        end
        'state3:
        begin
            present= A? 'state0: 'state1;
            Z=1'b0;
        end
        endcase
        pres_st <= present;
    end
    endmodule
