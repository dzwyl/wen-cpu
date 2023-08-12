//-----------------------------------------------------------------------------------------------
//  Copyright    : 
//  File Name    : Div
//  Author       : Luk.wj
//  Data         : 2021.10.14
//  Description  : Any integer frequency division module
//-----------------------------------------------------------------------------------------------

module Div #(
    parameter    cnt_width = 3,   //counter bit width
    parameter    fre_div   = 4    //frequency division
) (
    input        rst_n,
    input        clk_in,
    output       clk_out
);

wire clk_in_n;

//====================================================  generate negedege !clk_in, 为了设计都是上升沿触发
assign clk_in_n = ~clk_in;

generate
    // Even四分频
    if (fre_div[0] == 1'b0) begin: div
        div_even#(
            .cnt_width ( cnt_width ),
            .fre_div   ( fre_div   )
        )u1_div_even(
            .rst_n     ( rst_n     ),
            .clk_in    ( clk_in    ),
            .clk_out   ( clk_out   )
        );
    end
    // Odd五分频
    else begin: div
        div_odd#(
            .cnt_width ( cnt_width ),
            .fre_div   ( fre_div   )
        )u1_div_odd(
            .rst_n     ( rst_n     ),
            .clk_in    ( clk_in    ),
            .clk_in_n  ( clk_in_n  ),
            .clk_out   ( clk_out   )
        );
    end
endgenerate

endmodule
