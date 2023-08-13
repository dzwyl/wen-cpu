`timescale 1ns / 1ps


module ahb_ctrl(
    input clk,
    input rstn,
    input wr,
    input rd,
    input [31:0]addr,
    input [31:0]wdata,

    output [31:0]rdata,
    output rd_en,

    output hsel,
//  output hready,
    output [1:0]htrans,
    output [2:0]hsize,
    output hwrite,
    output [31:0]haddr,
    output reg [31:0]hwdata,

    input hreadyin,
    input hresp,
    input [31:0]hrdata
);

parameter IDLE = 3'b001;
parameter S0 = 3'b010;
parameter S1 = 3'b100; 

reg [2:0] cs;
reg [2:0] ns;

reg [31:0] addr_reg;
reg [31:0] wdata_reg;
reg wr_reg ;
reg wr_reg2;
reg rd_reg ;
reg rd_reg2;

always @(posedge clk or negedge rstn) begin
    if(!rstn) 
        cs <= IDLE;
    else 
        cs <= ns;
end

always @(*) begin           //状态机
    case (cs)
        IDLE : begin
            if(wr||rd)begin
                ns = S0;            //读或写有效
            end 
            else begin
                ns = IDLE;
            end
            end
        S0 : begin
            ns = S1;                //自动跳转
            end
        S1 :begin
                if(hreadyin==1'b1 && (wr||rd))      
                    ns = S0;
                else if(hreadyin==1'b1)
                    ns = IDLE;
                else 
                    ns = S1;        //hready信号没来 保持
            end
        default: ns = IDLE ;
    endcase
end

always@(posedge clk or negedge rstn) begin 
    if (!rstn) begin
        wr_reg <= 1'b0;
        wr_reg2 <= 1'b0;
        rd_reg <= 1'b0;
        rd_reg2<= 1'b0;
    end else begin
        wr_reg <= wr;
        rd_reg <= rd;
        wr_reg2 <=wr_reg;
        rd_reg2<= rd_reg;
    end
end

always@(posedge clk or negedge rstn) begin 
        if(!rstn) begin
            addr_reg<=32'h0;
        end else if(wr || rd) begin
            addr_reg<=addr;
        end
end

always@(posedge clk or negedge rstn) begin 
    if(!rstn) begin
        wdata_reg<=32'h0;
    end else if(wr) begin 
        wdata_reg<=wdata;
    end
end

assign hsel = (cs==S0)||(cs==S1 &&(wr_reg || rd_reg)) ;
assign htrans = ( hsel == 1'b1 )? 2'h2:2'h0;                    // 00 BUSY 10 SEQ
assign hsize = ( hsel == 1'b1 )? 2'h2:2'h0;                     // 10 32bit
assign hwrite =wr_reg ;
assign haddr = ( hsel == 1'b1 )?addr_reg:32'h0;

always@(posedge clk or negedge rstn) begin
    if(!rstn) begin
        hwdata<=32'h0;
    end else if(hsel) begin 
        hwdata<=wdata_reg;
    end 
end 


assign rd_en = cs == S1 && hreadyin==1'b1&& (rd_reg2);
//assign rd_en = cs == S1 && hreadyin==1'b1&& (~wr_reg);
assign rdata = (rd_en == 1'b1 ) ? hrdata : 32'h0; 

endmodule