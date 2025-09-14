//Verilog: Structural Description of a N-bit Asynchronous Down Counter
module async_down_counter  (clr, clk, q);
    parameter N=4; // Number of bits in the counter
    input clk;       // Clock input
    input clr;     // Active-low clear
    output [N-1:0] q;   // Output count

    wire [N-1:0] clk_chain;//This is the clock ripple of first to next FF.
    // First flip-flop uses external clock
    //Get the clock directly from main clk input
    //The output (q[0]) of the first FF is used as the clock for the second FF, and so on.
    T_FF TFF0 (.clk(clk),.clr(clr),.q(q[0]));
    // assign output of first FF to input clock of second FF
    assign clk_chain[0] = q[0];

    genvar i;
    generate
        for (i = 1; i < N; i = i + 1) begin : DOWN_COUNTER
        // Each flip-flop[i+1] uses the output of flip-flop[i] as its clock input.
            T_FF TFFi (
                .clk(clk_chain[i-1]), // Ripple clock
                .clr(clr),
                .q(q[i])
            );
            assign clk_chain[i] = q[i];//assign output of FF[i] to input clock of FF[i+1]
        end
    endgenerate

    endmodule
module T_FF (
    input clk,
    input clr,
    output reg q
);
// FF only toggles when clk transitions from high to low (falling edge)
//and when clr is 1 (clr=1)
    always @(negedge clk or posedge clr) begin
        if (clr)//reset
            q <= 1'b1; // Optional: start from max (all 1s)
        else// Toggle the output on the falling edge of the clock
            q <= ~q;
    end
endmodule
