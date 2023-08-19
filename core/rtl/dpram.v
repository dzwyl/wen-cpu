`timescale 1ns / 1ps

module  dpram #(
    parameter WIDTH=32,
    parameter DEPTH=1024
)   (
    input                           clk,
    input                           wen,
    input                           ren,
    input       [clog2(DEPTH)-1:0]  addra,
    input       [WIDTH-1:0]         dina,
    input       [clog2(DEPTH)-1:0]  addrb,
    output  reg [WIDTH-1:0]         doutb
);

reg [WIDTH-1:0] BRAM [clog2(DEPTH)-1:0];

always @(posedge clk) begin
    if(wen) begin
        BRAM[addra] <= dina;
    end
    if(ren) begin
        doutb <= BRAM[addrb];
    end
end

function    integer clog2;
    input   integer depth;
    begin
        depth = depth-1;
        for(clog2=0; depth>0; clog2=clog2+1) begin
            depth = depth >> 1;
        end
    end
endfunction


endmodule