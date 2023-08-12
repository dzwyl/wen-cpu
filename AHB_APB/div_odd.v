//-----------------------------------------------------------------------------------------------
//  Copyright    : 
//  File Name    : div_odd
//  Author       : Luk.wj
//  Data         : 2021.10.13
//  Description  : Odd numkber frequency division
//-----------------------------------------------------------------------------------------------

module div_odd #(
    parameter    cnt_width = 3,   //counter bit width
    parameter    fre_div   = 5    //frequency division
) (
    input            rst_n,
    input            clk_in,
    input            clk_in_n,    //!clk_in，为了设计都是上升沿触发
    output           clk_out
);

reg  [cnt_width-1:0]    cnt_p, cnt_n;  //posedge, negedge count
reg  clk_p, clk_n;                     //posedge, negedge generate clock

//====================================================  clk_p unit
always @(posedge clk_in or negedge rst_n) begin
   if (!rst_n) begin
       cnt_p  <= 0;
       clk_p  <= 1'b0;
   end
   else if (cnt_p == (fre_div-1)/2) begin
       clk_p  <= ~clk_p;
       cnt_p  <= cnt_p + 1;
   end
   else if (cnt_p == (fre_div-1)) begin
       cnt_p  <= 0;
       clk_p  <= ~clk_p;
   end
   else
       cnt_p  <= cnt_p + 1;
end

//====================================================  clk_n unit
always @(posedge clk_in_n or negedge rst_n) begin
   if (!rst_n) begin
       cnt_n  <= 0;
       clk_n  <= 1'b0;
   end
   else if (cnt_n == (fre_div-1)/2) begin
       clk_n  <= ~clk_n;
       cnt_n  <= cnt_n + 1;
   end  
   else if (cnt_n == (fre_div-1)) begin
       cnt_n  <= 0;
       clk_n  <= ~clk_n;
   end
   else
       cnt_n  <= cnt_n + 1;   
end

assign clk_out = clk_p | clk_n;

endmodule
