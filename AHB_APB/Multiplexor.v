//-----------------------------------------------------------------------------------------------
//  Copyright    : 
//  File Name    : Multiplexor
//  Author       : Luk.wj
//  Create       : 2020.12.13
//  Revise       : 2021.12.20
//  Description  : 从机选择数据模块
//-----------------------------------------------------------------------------------------------

module Multiplexor (Hrdata_0,Hrdata_1,Hrdata_2,Hrdata_3,master_m,Prdata_m);
input      [31:0] Hrdata_0;
input      [31:0] Hrdata_1;
input      [31:0] Hrdata_2;
input      [31:0] Hrdata_3;
input      [31:0] master_m;
output reg [31:0] Prdata_m;

reg[3:0] addr_m;

always @(*) begin
    addr_m = master_m[11:8];
    case (addr_m)
        4'h0:       Prdata_m = Hrdata_0;
        4'h1:       Prdata_m = Hrdata_1;
        4'h2:       Prdata_m = Hrdata_2;
        4'h3:       Prdata_m = Hrdata_3;
        default:    Prdata_m = 32'h0;
    endcase
end

endmodule
