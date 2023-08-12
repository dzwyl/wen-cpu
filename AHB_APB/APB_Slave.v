//-----------------------------------------------------------------------------------------------
//  Copyright    : 
//  File Name    : APB_Slave
//  Author       : Luk.wj
//  Create       : 2020.12.01
//  Revise       : 2021.12.20
//  Description  : 
//-----------------------------------------------------------------------------------------------

module APB_Slave(PSELx,Pen,Paddr,Pwrite,Prst,PCLK,Pwdata,Prdata);
input              PSELx;          //从设备选择
input              Pen;            //使能
input              Pwrite;         //0为读，1为写
input              Prst;           //Reset,0为复位
input              PCLK;           //时钟，为HCLK的二分频
input      [31:0]  Paddr;          //地址
input      [31:0]  Pwdata;         //写数据
output reg [31:0]  Prdata;         //读数据   

reg [31:0] Slave_reg [31:0];       //定义16个32位寄存器
/* 从设备的地址
S0:  0x0000_0000 ~ 0x0000_00ff;
S1:  0x0000_0100 ~ 0x0000_01ff;
S2:  0x0000_0200 ~ 0x0000_02ff;
S3:  0x0000_0300 ~ 0x0000_03ff;
*/
wire [5:0] num;
assign num = Paddr[7:2];  //寄存器号

always @(posedge PCLK or negedge Prst ) begin
    if (!Prst)
        Prdata <= 32'h0000_0000;
    else begin
        if (PSELx & Pen) begin
            if (Pwrite)   Slave_reg[num] <= Pwdata;     
        end
        if (PSELx & (~Pen)) begin  //为了让信号提前传输
            if (!Pwrite)  Prdata <= Slave_reg[num];
        end    
    end
end

endmodule
