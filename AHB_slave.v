`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.12.2024 15:23:14
// Design Name: 
// Module Name: AHB_slave
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


module AHB_slave(
input Hclk,
input Hresetn,
input Hwrite,
input Hreadyin,
input [1:0]Htrans,
input [31:0]Haddr,
input [31:0]Hwdata,


output reg valid,
output reg [31:0]Haddr1,
output reg [31:0]Haddr2,
output reg [31:0]Hwdata1,
output reg [31:0]Hwdata2,
output reg Hwritereg,
output reg [2:0]tempselx,
output  [1:0] Hresp,
output  [31:0] Hrdata

    );
      // Hresp 00=ok, 01=error    10=split 11=retry;
    // Here 1 master and 3 slaves are there no retry always okk response will be there
    assign Hresp=2'b00;
    always@(*)
    begin
    if(!Hresetn)begin
    valid=1'b0;
    end
    
    else if(Hreadyin && (Htrans==2'b10 || Htrans==2'b11) && (Haddr>=32'h80000000 && Haddr<=32'h8C000000))
    begin
    valid=1'b1;
    end
    
    else 
    valid=1'b0;
    end
    
    always@(*)
    begin
    
    if(!Hresetn)
    tempselx=3'b000;
    
    else if(Haddr>=32'h80000000 && Haddr<32'h84000000)
    tempselx=3'b001;
    else if(Haddr>=32'h84000000 && Haddr<32'h88000000)
    tempselx=3'b010;
    else if(Haddr>=32'h88000000 && Haddr<32'h8C000000)
    tempselx=3'b100;
    end
    
    always@(posedge Hclk)
    begin
    if(!Hresetn)
    begin
    Haddr1<=32'b0;
    Haddr2<=32'b0;
    end
    
    else
    begin
    Haddr1<=Haddr;
    Haddr2<=Haddr1;
    end
    end
    
     always@(posedge Hclk)
    begin
    if(!Hresetn)
    begin
    Hwdata1<=32'b0;
    Hwdata2<=32'b0;
    end
    
    else
    begin
    Hwdata1<=Hwdata;
    Hwdata2<=Hwdata1;
    end
    end
    
    always@(posedge Hclk)
    begin
    if(!Hresetn)
    begin
    Hwritereg<=1'b0;
    end
    else
    begin
    Hwritereg<=Hwrite;
    end
    end
  
    
    
endmodule
