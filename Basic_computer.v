//Verilog: HDL descritpion of BASIC COMPUTER
//This machine includes DECODE; FSM; SRAM; AC; ALU; IR;PC;AR;DR
module computer_basic(ON_OFF,PC,clk_master,ACH,ACL,Reset);
parameter STATE_FETCH1=2'b00;
parameter STATE_FETCH2=2'b01;
parameter STATE_DECODE=2'b10;
parameter STATE_EXECUTE=2'b11;

input ON_OFF,clk_master;
input reset;
output reg [3:0] PC;
output reg [7:0] ACH,ACL;
reg [1:0] state;
reg [15:0] PR;
reg [2:0] IR;
reg [3:0] AR;
reg [7:0] DR;
reg [7:0] Memory [0:15];
wire clk= clk_master & ON_OFF;// Declare and value of function at the same time 
// This is parity generator(even parity or odd parity)
wire parity_bit=^ACL[6:0];// XOR of 7 LSBs
//Initialization, all value must be zero.
initial begin
        PC=4'd0;
        ACL=8'd0;
        ACH=8'd0;
        state = STATE_FETCH1;

// Initial the contents of Memory   
        Memory[0]= 8'hE0;
        Memory[1]=8'h29;
        Memory[2]=8'h8A;
        Memory[3]=8'h4B;
        Memory[4]=8'h6C;
        Memory[5]=8'h8D;
        Memory[6]=8'hCE;
        Memory[7]=8'hA0;
        Memory[8]=8'h00;
        Memory[9]=8'h0C;
        Memory[10]=8'h05;
        Memory[11]=8'h04;
        Memory[12]=8'h09;
        Memory[13]=8'h03;
        Memory[14]=8'h09;
        Memory[15]=8'h07;
end
always @(posedge clk or posedge reset) begin
    if(reset) begin
        PC<=4'd0;
        ACL<=8'd0;
        ACH<=8'd0;
        state<= STATE_FETCH1;
    end else begin
    case(state) 
        //FETCH
        STATE_FETCH1:
        begin
            state<=STATE_FETCH2;
            AR<=PC;// Copy the address to AR for READING
        end
        STATE_FETCH2;
        begin
            state<= STATE_DECODE;
            DR<=Memory[AR];
        end
        state2
        begin
            next_state=state3;
            PC<=PC+1;
            IR<=DR[7:5]// Paste the OPCODE TO CONFIRM THE ACTION to send to Decoder
            AR<=DR[3:0]// Paste the address to AR to get the value from Memory[9]
        end
        // DECODE
        STATE_DECODE: begin
            PC<= PC+1;
            IR<= DR[7:5];// opcode
            AR<= DR[4:0];// address of the value
            state<=STATE_EXECUTE;
        end
        // EXECUTE
        STATE_EXECUTE: begin
            case(IR) 
                3'b000: begin // HALT
                    state<=STATE_EXECUTE;
                end
                3'b001: begin // ADD
                    DR<= Memory[AR];
                    ACL<= ACL + DR;
                    state<=STATE_FETCH1;
                end
                3'b010: begin //MULT
                    DR<=Memory[AR];
                    AC<=ACL*DR;
                    ACL<= PR[7:0];// MAIN VALUE
                    ACH<= PR[15:8];// IF VALUE > 8 bits
                    state<=STATE_FETCH1;
                end
                3'b011: begin //DIVIDE
                    DR<=Memory[AR];
                    ACL<=ACL/DR;
                    state<=STATE_FETCH1;
                end
                3'b100: begin // XOR
                    DR<=Memory[AR];
                    ACL<=ACL^DR;
                    state<=STATE_FETCH1;
                end
                3'b101: begin // Parity
                    ACL[7]<=parity_bit;// check
                    state<=STATE_FETCH1;
                end
                3'b110: begin //NAND
                    DR<= Memory[AR];
                    ACL<=~(ACL&DR);
                    state<=STATE_FETCH1;
                end
                3'd111: begin// CLA
                    ACL<=8'd0;
                    state<=STATE_FETCH1;
                end
                default: state<=STATE_FETCH1; 
            endcase
        end
    endcase
end//else
end//always
endmodule
