class driver extends uvm_driver#(seq_item);
  `uvm_component_utils(driver)
  
  function new(string name = "driver", uvm_component parent = null);
    super.new(name, parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction
  
  task run_phase (uvm_phase phase);
    forever begin
      seq_item_port.get_next_item(req);
      void'(req.randomize());
      #50; // Driving delay. Assuming time taken to drive RTL signals
      `uvm_info(get_name, $sformatf("addr = %0h and data = %0h", req.addr, req.data), UVM_LOW);
      seq_item_port.item_done();
    end
  endtask
endclass