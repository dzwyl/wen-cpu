//-----------------------------------------------------------------------------------------------
//  Copyright    : 
//  File Name    : APB_Bridge
//  Author       : Luk.wj
//  Create       : 2020.12.14
//  Revise       : 2021.12.20
//  Description  : APB_Bridge的作用是将主设备的访问信号转化成APB总线信号访问从设备
//-----------------------------------------------------------------------------------------------

/* State */
`define Idle    2'b00
`define Setup   2'b01
`define Access  2'b10

module APB_Bridge (PCLK,Prst,Haddr,Hwdata,Hwrite,Hen,Prdata_m,Paddr,Pen,Pwrite,Pwdata,Hrdata,Hready,PSEL0,PSEL1,PSEL2,PSEL3);
input PCLK;
input Prst;

/* AHB_Master */
input               Hwrite;
input               Hen;
input      [31:0]   Haddr;
input      [31:0]   Hwdata;
output reg          Hready;
output reg [31:0]   Hrdata;

/* APB_Slave */
input      [31:0]   Prdata_m;
output reg          Pen;
output reg          Pwrite;
output reg          PSEL0;
output reg          PSEL1;
output reg          PSEL2;
output reg          PSEL3;
output reg [31:0]   Pwdata;
output reg [31:0]   Paddr;

reg        [1:0]    APB_State;     //APB状态参数
reg        [23:0]   addr_d;        //截取总线地址的前24位选择从设备

/* 四个从设备内部变量 */
reg Hsel0;              
reg Hsel1;
reg Hsel2;
reg Hsel3;

/* Read Data */
always @(*) begin
    if (!Prst)   Hrdata = 32'h0;
    else         Hrdata = Prdata_m;
end

/* Slave Select */
always @(*) begin
    addr_d = Haddr[31:8];
    Hsel0  = 1'b0;
    Hsel1  = 1'b0;
    Hsel2  = 1'b0;
    Hsel3  = 1'b0;
    case (addr_d)
        24'h0000_00:      Hsel0 = 1'b1;
        24'h0000_01:      Hsel1 = 1'b1;
        24'h0000_02:      Hsel2 = 1'b1;
        24'h0000_03:      Hsel3 = 1'b1;
        default:   begin
            Hsel0 = 1'b0;
            Hsel1 = 1'b0;
            Hsel2 = 1'b0;
            Hsel3 = 1'b0;
        end  
    endcase
end

/* APB FSM */
always @(posedge PCLK or negedge Prst) begin
    if (!Prst) begin
        //AHB_Master
        Hready <= 1'b0;

        //APB_Slave
        APB_State <= `Idle;
        PSEL0     <= 1'b0;
        PSEL1     <= 1'b0;
        PSEL2     <= 1'b0;
        PSEL3     <= 1'b0;
        Pen       <= 1'b0;
        Pwrite    <= 1'b0;
        Pwdata    <= 32'b0;
        Paddr     <= 32'b0;
    end
    else begin
        case (APB_State)
            `Idle: begin
                if (Hen) begin
                    APB_State <= `Setup;
                    PSEL0  <= Hsel0;
                    PSEL1  <= Hsel1;
                    PSEL2  <= Hsel2;
                    PSEL3  <= Hsel3;
                    Pwrite <= Hwrite;
                    Paddr  <= Haddr;
                    Pwdata <= Hwdata;
                    Hready <= 1'b0;
                end
            end
            `Setup: begin
                APB_State <= `Access;
                Pen <= 1'b1;
                Hready <= 1'b0;
            end
            `Access: begin
                APB_State <= `Idle;
                Pen       <= 1'b0;
                PSEL0     <= 1'b0;
                PSEL1     <= 1'b0;
                PSEL2     <= 1'b0;
                PSEL3     <= 1'b0;
                Hready    <= 1'b1;
            end
            default: APB_State <= `Idle;
        endcase
    end
end

endmodule
