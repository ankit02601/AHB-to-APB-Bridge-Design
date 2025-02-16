`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.01.2025 19:15:17
// Design Name: 
// Module Name: AHB_Master
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


module AHB_Master(
input Hclk,Hresetn,Hreadyout,
input[31:0] Hrdata,
output reg[31:0] Haddr,Hwdata,
output reg Hwrite,Hreadyin,
output reg [1:0]Htrans
    );
    
 // Internal Variables
 reg[2:0]Hburst;
 reg[2:0] Hsize;
 
 integer i,j;
 // single write
assign  Hrdata=32'h80000000;
 task Single_write();
 begin
 @(posedge Hclk)
 #5;
 begin
 Hwrite=1;
 Htrans=2'b10;//means non sequential
 Hsize=0; // means 1 byte transfer
 Hburst=3'b000; // INCR 4 , 4bit incrementing Burst
 Hreadyin=1;
 Haddr=32'h80000001;
 end
 @(posedge Hclk)
 #5;
 begin
 Htrans=2'b00; // IDLE means no transfer is required
 Hwdata=8'h80;
 end
 end
 endtask
 
 
 // Single Read
 
 task single_read();
 begin
 @(posedge Hclk)
 begin
 Hwrite=0;
 Htrans=2'b10;//means non sequential
 Hsize=0; // means 1 byte transfer
 Hburst=3'b000; // Single transfer
 Hreadyin=1;
 Haddr=32'h80000001;
 
 end
 
 @(posedge Hclk)
 #5;
 begin
 
 Htrans=2'b00;
 end
 end
 endtask
 
 // Burst write
 task burst_write();
 begin
 @(posedge Hclk)
 #5;
 begin
  Hwrite=1;
 Htrans=2'b10;//means non sequential
 Hsize=0; // means 1 byte transfer
 Hburst=3'b011; // 4 bit transfer
 Hreadyin=1;
 Haddr=32'h80000001;
 end
 @(posedge Hclk)
 #5;
 begin
 Haddr=Haddr+1'b1;
 Hwdata={$random}%256;
 Htrans=2'b11; //sequence
 end
 
 for(i=0;i<2;i=i+1)
 begin
 @(posedge Hclk);
 #1;
 Haddr=Haddr+1;
  Hwdata={$random}%256;
 Htrans=2'b11; //sequence
 end
 @(posedge Hclk)
 #1;
 begin
 Hwdata={$random}%256;
 Htrans=2'b00;
 end
 end
 endtask
 
 // Burst Read
 task burst_Read();
 begin
 @(posedge Hclk)
 #5;
 begin
  Hwrite=1'b0;
 Htrans=2'b10;//means non sequential
 Hsize=0; // means 1 byte transfer
 Hburst=3'b011; // 4 bit transfer
 Hreadyin=1;
 Haddr=32'h80000001;
 end
 @(posedge Hclk)
 #5;
 begin
 Haddr=Haddr+1'b1;
 
 Htrans=2'b11; //sequence
 end
 
 for(i=0;i<2;i=i+1)
 begin
 @(posedge Hclk);
 #1;
 Haddr=Haddr+1;
  //Hwdata={$random}%256;
 Htrans=2'b11; //sequence
 end
 @(posedge Hclk)
 #1;
 begin
 //Hwdata={$random}%256;
 Htrans=2'b00;
 end
 end
 endtask
 
endmodule
