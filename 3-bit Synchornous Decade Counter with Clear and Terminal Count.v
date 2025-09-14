//Verilog 3-bit Synchornous Decade Counter with Clear and Terminal Count
//The counter counts from 000 to 1001 (0 to 9 in decimal)
//When the counter reaches its maximum value (1001 in binary), tc will be set to 1
//On the next clock pulse, the counter will reset to 000 and tc will return to 0
module decade_counter_4bit(clk, clrbar, q, tc);
    input clk,clrbar;
    output reg [3:0] q;
    output reg tc;
    wire clr;
    not(clr,clrbar);//clr = active high clear

    always @(posedge clk)begin
        if(!clrbar)//clr=1-> reset
            begin q<=4'b0000; tc<=0; end
        else
        begin
            if(q=4'b1001)// q=9
                begin 
                    q<=4'b0000; tc<=1; // reset lai
                end
            else
                begin q<=q+1; tc<=0; end
        end

    end
    endmodule
