class driver extends uvm_driver#(seq_item);
  virtual sfr_if vif;
  `uvm_component_utils(driver)
  
  function new(string name = "driver", uvm_component parent = null);
    super.new(name, parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual sfr_if) :: get(this, "", "vif", vif))
      `uvm_fatal(get_type_name(), "Not set at top level");
  endfunction
  
  task run_phase (uvm_phase phase);
    forever begin
      // Driver to the DUT
      seq_item_port.get_next_item(req);
      //void'(req.randomize());
      // Driving Logic
      @(posedge vif.clk);
      vif.i_rd_en <= req.rd_or_wr;
      vif.i_wr_en <= !req.rd_or_wr;
      
      if(req.rd_or_wr) begin // Read Operation
        vif.i_raddr <= req.addr;
        //@(posedge vif.clk);
        wait(vif.o_rvalid)
        req.data = vif.o_rdata;        
        `uvm_info(get_type_name(), $sformatf("raddr = %0h, rdata = %0h", req.addr, req.data), UVM_LOW);
      end 
      else begin // Write Operation
        vif.i_waddr <= req.addr;
        vif.i_wdata <= req.data;
        //@(posedge vif.clk);
        wait(vif.o_wready);
        `uvm_info(get_type_name(), $sformatf("waddr = %0h, wdata = %0h", req.addr, req.data), UVM_LOW);
      end
      seq_item_port.item_done();
    end
  endtask
endclass
