// Verilog 16x8 SRAM(Static Memory)
module SRAM_asynchronoys_memory(ABUS,CS, Data_in, Data_out,R_Write_bar);
input R_Write_bar,CS;
input [3:0] ABUS;
input [7:0] Data_in;
output reg [7:0] Data_out;
reg [7:0] Memory [0:15];// Create a memory with the wide is 16 words, each word has 8 bits.

always @(R_Write_bar,CS,Data_in,ABUS) begin
    if (CS)begin
        if(!R_Write_bar) begin
            Memory[ABUS]<= Data_in;// write
            Data_out =8'bzzzzzzzz;// while writing the reading function is high impediance
        end
        else 
            Data_out<= Memory[ABUS];// read
    end
    else 
        Data_out= 8'bzzzzzzzz;
end
endmodule
module SRAM_synchronous_memory(clk,CS,ABUS,Data_in,Data_out,RW_bar);
input CS, RW_bar,clk;
input [3:0] ABUS;
input [7:0] Data_in;
output reg [7:0] Data_out;
reg [7:0] Memory [0:15]; // 16 elements, 1 element has 8 bits

always @( posedge clk) begin
    if(CS) begin
        if(!@RW_bar)
        Memory[ABUS]<= Data_in;
        else 
        Data_out<= Memory[ABUS];
    end
    // else do nothing. Keeps its value.
end
endmodule
