//-----------------------------------------------------------------------------------------------
//  Copyright    : 
//  File Name    : div_even
//  Author       : Luk.wj
//  Data         : 2021.10.13
//  Description  : Even frequency division
//-----------------------------------------------------------------------------------------------

module div_even #(
    parameter    cnt_width = 3,   //counter bit width
    parameter    fre_div   = 4    //frequency division
) (
    input            rst_n,
    input            clk_in,
    output reg       clk_out
);

reg  [cnt_width-1:0]    cnt;  

always @(posedge clk_in or negedge rst_n) begin
   if (!rst_n) begin
       cnt     <= 0;
       clk_out <= 1'b0;
   end
   else if (cnt == (fre_div/2-1)) begin
       cnt     <= 0;
       clk_out <= ~clk_out;
   end
   else
       cnt <= cnt + 1;
end

endmodule
