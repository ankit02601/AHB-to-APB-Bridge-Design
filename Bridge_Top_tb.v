`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.01.2025 18:43:28
// Design Name: 
// Module Name: Bridge_Top_tb
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


module Bridge_Top_tb( );
reg Hclk,Hresetn;
wire [31:0] Haddr,Hwdata,Hrdata,Paddr,Pwdata,Pwdata_out,Paddr_out,Prdata;
wire [1:0] Hresp,Htrans;
wire [2:0] tempselx,Pselx,Psel_out;
wire Hreadyout,Hwrite,Hreadyin,Hwrite_reg1,Hwrite_reg2,Penable,Pwrite_out,Penable_out;

AHB_Master ahb(Hclk,Hresetn,Hreadyout,Hrdata,Haddr,Hwdata,Hwrite,Hreadyin,Htrans);

APB_Interface apb(Pwrite,Penable,Pselx,Paddr,Pwdata,Pwrite_out,Penable_out,Psel_out,Paddr_out,Pwdata_out,Prdata);

 Bridge_Top bridge(Hclk,Hresetn,Hwrite,Hreadyin,Hwdata,Haddr,Htrans,Prdata,Penable,Pwrite,Pselx,Paddr,Pwdata,Hreadyout,Hresp,Hrdata); 
  
  initial begin
  Hclk=1'b0;
  forever #10 Hclk=~Hclk;
  end
  
  task reset();
  begin
  @(negedge Hclk)
  Hresetn=1'b0;
  @(negedge Hclk)
  Hresetn=1'b1;
  end
  endtask
  
  initial
  begin
  reset;
  //ahb.Single_write();
  // ahb.burst_write();
  //ahb.single_read();
  ahb.burst_Read();
  end
endmodule

