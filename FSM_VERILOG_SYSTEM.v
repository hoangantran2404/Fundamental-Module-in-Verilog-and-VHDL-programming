// REMEMBER: Next_state will depends on 2 factors, which are current_state(case) and input(if)
module FSM (
        input  logic A,         // input
        input  logic clk,       // clock
        output logic [1:0] pres_st,// state
        output logic Z              // the final result
    );
    // Use enum to define all the state
    typedef enum logic [1:0] {
        state0 = 2'b00,
        state1 = 2'b01,
        state2 = 2'b10,
        state3 = 2'b11
    } state_t;// the common name is state_t

    state_t current_state, next_state; // state_t includes current_state and next_state

    assign pres_st = current_state; // DO NOT put it in the always block, use a mid way

    always_ff @(posedge clk) begin// synchronous clock, current_state will equal next_state when clk changes
        current_state <= next_state;
    end

    always_comb begin
        case (current_state)// Depends on current state
            state0: begin
                next_state = A ? state1 : state0; // Depends on the input
                Z = A ? 1'b0 : 1'b1;
            end
            state1: begin
                next_state = A ? state2 : state3;
                Z = 1'b0;
            end
            state2: begin
                next_state = A ? state3 : state0;
                Z = 1'b0;
            end
            state3: begin
                next_state = A ? state0 : state2;
                Z = 1'b0;
            end
        endcase
    end

    endmodule
