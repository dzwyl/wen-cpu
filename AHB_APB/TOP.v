//-----------------------------------------------------------------------------------------------
//   Copyright         :        
//   Author            :        Luk.wj
//   File Name         :        TOP
//   Module Name       :        TOP
//   Create            :        2020.12.14
//   Revise            :        2021.12.17
//   Fuction           :        顶层连接文件
//-----------------------------------------------------------------------------------------------
module TOP (HCLK,Tstart,Twrite,Taddr,Twdata,Rst,Trdata);
input           HCLK;
input           Tstart;
input           Twrite;
input           Rst;
input  [31:0]   Taddr;
input  [31:0]   Twdata;
output [31:0]   Trdata;

/* AHB_Master */
wire            Hready;
wire   [31:0]   Hrdata;

/* APB_Bridge */
wire            Hwrite;
wire            Hen;
wire   [31:0]   Haddr;
wire   [31:0]   Hwdata;
wire   [31:0]   Prdata_m;

/* APB_Slave */
wire            PCLK;
wire            PSEL0, PSEL1, PSEL2, PSEL3;
wire            Pen;
wire            Pwrite;
wire   [31:0]   Pwdata;
wire   [31:0]   Paddr;

/* Multiplexor */
wire   [31:0]   Hrdata_0, Hrdata_1, Hrdata_2, Hrdata_3;

/* Define Relationship */
AHB_Master Master(
    //Test
    .Twrite      (Twrite),
    .Taddr       (Taddr),
    .Twdata      (Twdata),
    .Tstart      (Tstart),
    .Trdata      (Trdata),
    //Input
    .Hrdata      (Hrdata),
    .HCLK        (HCLK),
    .Hrst        (Rst),
    .Hready      (Hready),
    //Output
    .Haddr       (Haddr),
    .Hwdata      (Hwdata),
    .Hwrite      (Hwrite),
    .Hen         (Hen)
);

Div#(
    .cnt_width ( 2 ),
    .fre_div   ( 2 )
)u_Div(
    .rst_n     ( RST       ),
    .clk_in    ( HCLK      ),
    .clk_out   ( PCLK      )
);

APB_Bridge Bridge(
    //Input
    .Haddr       (Haddr),
    .Hwdata      (Hwdata),
    .Hwrite      (Hwrite),
    .Hen         (Hen),
    .Prdata_m    (Prdata_m),
    .PCLK        (PCLK),
    .Prst        (Rst),
    //Output
    .Paddr       (Paddr),
    .PSEL0       (PSEL0),
    .PSEL1       (PSEL1),
    .PSEL2       (PSEL2),
    .PSEL3       (PSEL3),
    .Pen         (Pen),
    .Pwrite      (Pwrite),
    .Pwdata      (Pwdata) ,
    .Hready      (Hready),
    .Hrdata      (Hrdata)
);

APB_Slave Slave0(
    //Input
    .Paddr       (Paddr),
    .PSELx       (PSEL0),
    .Pen         (Pen),
    .Pwrite      (Pwrite),
    .Pwdata      (Pwdata) ,
    .Prst        (Rst),
    .PCLK        (PCLK),
    //Output
    .Prdata      (Hrdata_0)
);

APB_Slave Slave1(
    //Input
    .Paddr       (Paddr),
    .PSELx       (PSEL1),
    .Pen         (Pen),
    .Pwrite      (Pwrite),
    .Pwdata      (Pwdata) ,
    .Prst        (Rst),
    .PCLK        (PCLK),
    //Output
    .Prdata      (Hrdata_1)
);

APB_Slave Slave2(
    //Input
    .Paddr       (Paddr),
    .PSELx       (PSEL2),
    .Pen         (Pen),
    .Pwrite      (Pwrite),
    .Pwdata      (Pwdata) ,
    .Prst        (Rst),
    .PCLK        (PCLK),
    //Output
    .Prdata      (Hrdata_2)
);

APB_Slave Slave3(
    //Input
    .Paddr       (Paddr),
    .PSELx       (PSEL0),
    .Pen         (Pen),
    .Pwrite      (Pwrite),
    .Pwdata      (Pwdata) ,
    .Prst        (Rst),
    .PCLK        (PCLK),
    //Output
    .Prdata      (Hrdata_3)
);

Multiplexor Mul(
    //Input
    .Hrdata_0    (Hrdata_0),
    .Hrdata_1    (Hrdata_1),
    .Hrdata_2    (Hrdata_2),
    .Hrdata_3    (Hrdata_3),
    .master_m    (Paddr),
    //Output
    .Prdata_m    (Prdata_m)
);

endmodule
