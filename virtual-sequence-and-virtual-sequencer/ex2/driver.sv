class base_driver extends uvm_driver#(seq_item);
  `uvm_component_utils(base_driver)
  
  function new(string name = "base_driver", uvm_component parent = null);
    super.new(name, parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction
  
  task run_phase (uvm_phase phase);
    forever begin
      seq_item_port.get_next_item(req);
      void'(req.randomize());
      drive(req);
      seq_item_port.item_done();
    end
  endtask
  
  virtual task drive(seq_item req);
    `uvm_info(get_type_name(), "Driving from base_driver", UVM_LOW);
  endtask
endclass

class core_A_driver extends base_driver;
  `uvm_component_utils(core_A_driver)
  
  function new(string name = "core_A_driver", uvm_component parent = null);
    super.new(name, parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction
  
  task drive(seq_item req);
    `uvm_info(get_type_name(), "Driving from core A", UVM_LOW);
    #50; // Drive to DUT
  endtask
endclass

class core_B_driver extends base_driver;
  `uvm_component_utils(core_B_driver)
  
  function new(string name = "core_B_driver", uvm_component parent = null);
    super.new(name, parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction

  task drive(seq_item req);
    `uvm_info(get_type_name(), "Driving from core B", UVM_LOW);
    #50; // Drive to DUT
  endtask
endclass