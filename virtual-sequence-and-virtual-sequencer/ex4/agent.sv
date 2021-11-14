class core_A_agent extends uvm_agent;
  core_A_driver drv_A;
  core_A_sequencer seqr_A;
  `uvm_component_utils(core_A_agent)
  
  function new(string name = "core_A_agent", uvm_component parent = null);
    super.new(name, parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    drv_A = core_A_driver::type_id::create("drv_A", this);
    seqr_A = core_A_sequencer::type_id::create("seqr_A", this);
  endfunction
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    drv_A.seq_item_port.connect(seqr_A.seq_item_export);
  endfunction
endclass

class core_B_agent extends uvm_agent;
  core_B_driver drv_B;
  core_B_sequencer seqr_B;
  `uvm_component_utils(core_B_agent)
  
  function new(string name = "core_B_agent", uvm_component parent = null);
    super.new(name, parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    drv_B = core_B_driver::type_id::create("drv_B", this);
    seqr_B = core_B_sequencer::type_id::create("seqr_B", this);
  endfunction
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    drv_B.seq_item_port.connect(seqr_B.seq_item_export);
  endfunction
endclass