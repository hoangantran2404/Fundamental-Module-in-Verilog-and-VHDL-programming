module booth_multiplier #(parameter N = 4)(
    input signed [N-1:0] multiplicand,
    input signed [N-1:0] multiplier,
    output reg signed [2*N-1:0] product
    );

    reg [N:0] A, S;
    reg [2*N:0] P;
    integer i;

    always @(*) begin
        A = {multiplicand, {N{1'b0}}};        // A = M << N
        S = {-multiplicand, {N{1'b0}}};       // S = -M << N
        P = {{N{1'b0}}, multiplier, 1'b0};    // P = Q, Q-1

        // Booth Algorithm
        for (i = 0; i < N; i = i + 1) begin
            case (P[1:0])
                2'b01: P = P + A;     
                2'b10: P = P + S;    
                default: ;          
            endcase
          P = $signed(P) >>> 1;  //Arithm shift-right and sign preseving
        end

      product = P[2*N:1];  // Remove the last bit (Q-1)
    end
    endmodule
