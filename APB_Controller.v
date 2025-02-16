`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.01.2025 18:20:01
// Design Name: 
// Module Name: APB_controller
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


module APB_controller(
input Hclk,
input Hresetn,
input [31:0] Hwdata,
input [31:0] Haddr,
input valid,
input Hwrite,
input [31:0] Haddr1,
input [31:0] Haddr2,
input [31:0] Hwdata1,
input [31:0] Hwdata2,
input Hwritereg,
input [2:0] tempselx,
input [31:0]Prdata,
output reg Pwrite,
output reg Penable,
output reg [2:0]Pselx,
output reg [2:0]Pwdata,
output reg [31:0]Paddr,
output reg Hreadyout


    );
    
  parameter ST_IDLE=3'b000;
  parameter ST_WWAIT=3'b001;
  parameter ST_WRITEP=3'b010;
  parameter ST_WENABLEP=3'b011;
  parameter ST_WRITE=3'b100;
  parameter ST_WENABLE=3'b101;
  parameter ST_READ=3'b110;
  parameter ST_RENABLE=3'b111;
  
  reg[2:0] P_state,N_state;
   reg Pwrite_temp;
   reg Penable_temp;
   reg [2:0]Pselx_temp;
   reg [2:0]Pwdata_temp;
   reg [31:0]Paddr_temp;
   reg Hreadyout_temp;
  
  always@(posedge Hclk)
  begin
  if(!Hresetn)
  P_state<=ST_IDLE;
  else
  P_state<=N_state;
  end
  
  always@(*)
  begin
  case(P_state)
  ST_IDLE:if(valid && Hwrite)
  N_state=ST_WWAIT;
  else if(valid && ~Hwrite)
  N_state=ST_READ;
  else
  N_state=ST_IDLE;
  
  ST_WWAIT:if(valid)
  N_state=ST_WRITEP;
  else 
  N_state=ST_WRITE;
  
  ST_WRITEP: N_state=ST_WENABLEP;
  
  ST_WRITE:if(valid)
  N_state=ST_WENABLEP;
  else
  N_state=ST_WENABLE;
  
  ST_WENABLEP:if(valid && Hwritereg)
  N_state=ST_WRITEP;
  else if(~valid && Hwritereg)
  N_state=ST_WRITE;
  else if(~Hwritereg)
  N_state=ST_READ;
  
  ST_WENABLE:if(valid && Hwrite)
  N_state=ST_WWAIT;
  else if(valid && ~Hwrite)
  N_state=ST_READ;
  else if(~valid)
  N_state=ST_IDLE;
  
  ST_READ:N_state=ST_RENABLE;
  
  ST_RENABLE:if(valid && ~Hwrite)
  N_state=ST_READ;
  else if(valid && Hwrite)
  N_state=ST_WWAIT;
  else if(~valid)
  N_state=ST_IDLE;
  
  endcase
  end
  // Temporary logic
  always@(*)
  begin
  case(P_state)
  ST_IDLE:if(valid && Hwrite)
  begin
  Pselx_temp=3'b000;
  Penable_temp=1'b0;
  Hreadyout_temp=1'b1;
  end
  
  else if(valid && ~Hwrite)
  begin
  Paddr_temp=Haddr;
  Pwrite_temp=Hwrite;
  Pselx_temp=tempselx;
  Penable_temp=1'b0;
  Hreadyout_temp=1'b0;
  end
  
  else
  begin
  Pselx_temp=3'b000;
  Penable_temp=1'b0;
  Hreadyout_temp=1'b1;
  end
  
 ST_WWAIT:if(valid) begin
 Paddr_temp=Haddr2;
 Pwrite_temp=Hwrite;
 Pselx_temp=tempselx;
 Penable_temp=1'b0;
 Hreadyout_temp=1'b0;
 end
 
 else begin
 Paddr_temp=Haddr;
 Pwrite_temp=Hwrite;
 Pselx_temp=tempselx;
 Penable_temp=1'b0;
 Hreadyout_temp=1'b0;
 end
 
 ST_WRITE:if(~valid)
 begin
 Penable_temp=1'b1;
 Hreadyout_temp=1'b1;
 end
 
  ST_WENABLE:if(~valid)
  begin
  Pselx_temp=3'b000;
  Penable_temp=1'b0;
  end
  
  
  
  ST_WRITEP:
   begin
   Paddr_temp=Haddr2;
  Pwrite_temp=Hwrite;
  Pselx_temp=tempselx;
  Penable_temp=1'b0;
  Hreadyout_temp=1'b0;
  end
  
  ST_WENABLEP:if(valid && Hwritereg)
  begin
  Penable_temp=1'b1;
  Hreadyout_temp=1'b1;
  end
  else if(~valid && Hwritereg)
  begin
    Penable_temp=1'b0;
  Hreadyout_temp=1'b0;
  end
  
  ST_READ:begin
  Paddr_temp=Haddr;
  Pwrite_temp=Hwrite;
  Pselx_temp=1'b1;
  Penable_temp=1'b1;
  Hreadyout_temp=1'b1;
  end
  
  ST_RENABLE:begin
  Pselx_temp=1'b0;
  Penable_temp=1'b0;
  end
  endcase
  end
  // output logic
  always@(posedge Hclk)
  begin
  if(!Hresetn) begin
   Pwrite_temp<=1'b0;
    Penable_temp<=1'b0;
    Pselx_temp<=3'b000;
    Pwdata_temp<=32'b0;
    Paddr_temp<=32'b0;
    Hreadyout_temp<=1'b0;
    end
    
    else
    begin
    Pwrite<=Pwrite_temp;
    Penable<=Penable_temp;
    Pselx<=Pselx_temp;
    Pwdata<=Pwdata_temp;
    Paddr<=Paddr_temp;
    Hreadyout<=Hreadyout_temp;
    end
  end
  
  
  
  
  
   
endmodule
