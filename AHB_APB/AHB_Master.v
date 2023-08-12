//-----------------------------------------------------------------------------------------------
//  Copyright    : 
//  File Name    : AHB_Master
//  Author       : Luk.wj
//  Create       : 2020.12.13
//  Revise       : 2021.12.20
//  Description  : 
//-----------------------------------------------------------------------------------------------

module AHB_Master (Twrite,Taddr,Twdata,Tstart,Trdata,Hready,Hrst,HCLK,Hrdata,Haddr,Hwrite,Hwdata,Hen);
/* Test */
input               Tstart;          //主机启动
input               Twrite;
input      [31:0]   Taddr;
input      [31:0]   Twdata;
output reg [31:0]   Trdata;

/* AHB */
input               Hready;          //1传输结束，0需要延长
input               Hrst;            //Reset,0为有效
input               HCLK;            //时钟
input      [31:0]   Hrdata;          //从从机读回的数据
output reg          Hen;             //传输使能
output reg          Hwrite;          //1写，0读 
output reg [31:0]   Hwdata;          //写数据
output reg [31:0]   Haddr;           //地址

reg        [1:0]    AHB_rsp;         //表示传输状态,00进地址、控制信号和读数据，10进数据

always @(posedge HCLK or negedge Hrst) begin
    if (!Hrst) begin
        Haddr   <= 32'h0000_0000;
        Hwrite  <= 1'b0;
        Hwdata  <= 32'h0000_0000;
        Trdata  <= 32'h0000_0000;
        Hen     <= 1'b0;
        AHB_rsp <= 2'b00; 
    end
    else begin
        if (Tstart) begin    
            case (AHB_rsp)
                2'b00: begin
                    Haddr   <= Taddr;
                    Hwrite  <= Twrite;
                    AHB_rsp <= AHB_rsp + 1;
                    Hen     <= 1'b0;
                    Trdata  <= Hrdata; 
                end
                2'b01: begin
                    AHB_rsp <= AHB_rsp + 1;
                end
                2'b10: begin
                    Hwdata  <= Twdata;
                    Hen     <= 1'b1;
                    AHB_rsp <= AHB_rsp + 1;
                end
                2'b11: begin
                    if (Hready) AHB_rsp <= 2'b0;
                end
                default: AHB_rsp <= 2'b0;
            endcase
        end
    end
end

endmodule
