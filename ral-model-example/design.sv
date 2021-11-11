// Code your design here
module design_sfr(
  input clk,
  input reset_n,
  input i_wr_en, i_rd_en, 
  input [31:0] i_waddr, i_raddr, 
  input [31:0] i_wdata, 
  input [3:0] i_wstrobe, 
  output reg [31:0] o_rdata, 
  output reg o_wready,
  output reg o_rvalid
);
  

  // RTL registers
  reg [31:0] control_reg;
  reg [31:0] intr_sts_reg;
  reg [31:0] intr_msk_reg;
  reg [31:0] debug_reg;
  
  //reg [31:0] 
  always@(posedge clk) begin 
    if(!reset_n) begin
      control_reg  <= 5; //reset value
      intr_sts_reg <= 0;
      intr_msk_reg <= 1; // reset value
      debug_reg    <= 0;
      o_rvalid     <= 0;
    end
  end
  
  
  always @(posedge clk) begin
    if(i_wr_en) begin
      case(i_waddr)
        'h0 : control_reg  <= i_wdata;
        'h4 : intr_sts_reg <= i_wdata;
        'h8 : intr_msk_reg <= i_wdata;
        'hc : debug_reg    <= i_wdata;
      endcase
      o_wready <= 1; //Issue
      @(posedge clk);
      o_wready <= 0;
    end
    else o_wready <= 0;
  end
        
  always @(posedge clk) begin
    if(i_rd_en & !i_wr_en) begin
      case(i_raddr)
        'h0 : o_rdata <= control_reg;
        'h4 : o_rdata <= intr_sts_reg;
        'h8 : o_rdata <= intr_msk_reg;
        'hc : o_rdata <= debug_reg;
      endcase
      o_rvalid <= 1;
      @(posedge clk);
      o_rvalid <= 0;
    end
    else o_rvalid <= 0;
  end
endmodule
