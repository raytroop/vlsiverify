interface sfr_if(input logic clk, reset_n);
  logic  i_wr_en, i_rd_en;
  logic [31:0] i_waddr, i_raddr;
  logic [31:0] i_wdata; 
  logic [3:0] i_wstrobe; 
  //logic i_wvalid;
  //logic i_rready;
  logic [31:0] o_rdata;
  logic o_wready;
  logic o_rvalid;
endinterface