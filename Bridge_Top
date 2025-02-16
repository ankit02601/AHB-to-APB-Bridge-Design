`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.01.2025 15:29:08
// Design Name: 
// Module Name: Bridge_Top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Bridge_Top(
input Hclk,
input Hresetn,
input Hwrite,
input Hreadyin,
input [31:0]Hwdata,
input [31:0]Haddr,
input [1:0]Htrans,
input [31:0]Prdata,

output  Penable,
output  Pwrite,
output  [2:0]Pselx,
output  [31:0]Paddr,
output  [31:0]Pwdata,
output  Hreadyout,
output  [1:0]Hresp,
output  [31:0]Hrdata
    );
    
    wire valid,Hwritereg;
    wire [31:0] Haddr1,Haddr2;
    wire [31:0] Hwdata1,Hwdata2;
    wire [2:0] tempselx;
    
    AHB_slave uut1(.Hclk(Hclk),.Hresetn(Hresetn),.Hwrite(Hwrite),.Hreadyin(Hreadyin),.Htrans(Htrans),.Haddr(Haddr),.
    Hwdata(Hwdata),.valid(valid),.Haddr1(Haddr1),.Haddr2(Haddr2),.Hwdata1(Hwdata1),.Hwdata2(Hwdata2),.
    Hwritereg(Hwritereg),.tempselx(tempselx),.Hresp(Hresp),.Hrdata(Hrdata));
    
    APB_controller uut2(.Hclk(Hclk),.Hresetn(Hresetn),.Hwdata(Hwdata),.Haddr(Haddr),.valid(valid),.Hwrite(Hwrite),.
    Haddr1(Haddr1),.Haddr2(Haddr2),.Hwdata1(Hwdata1),.Hwdata2(Hwdata2),.Hwritereg(Hwritereg),.tempselx(tempselx),.
    Prdata(Prdata),.Pwrite(Pwrite),.Penable(Penable),.Pselx(Pselx),.Pwdata(Pwdata),.Paddr(Paddr),.Hreadyout(Hreadyout));
    
    assign Hresp=2'b00;
    
endmodule
