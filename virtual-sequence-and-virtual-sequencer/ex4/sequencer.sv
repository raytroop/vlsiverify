class core_A_sequencer extends uvm_sequencer #(seq_item);
  `uvm_component_utils(core_A_sequencer)
  
  function new(string name = "core_A_sequencer", uvm_component parent = null);
    super.new(name, parent);
  endfunction
  
endclass

class core_B_sequencer extends uvm_sequencer #(seq_item);
  `uvm_component_utils(core_B_sequencer)
  
  function new(string name = "core_B_sequencer", uvm_component parent = null);
    super.new(name, parent);
  endfunction
endclass

class virtual_sequencer extends uvm_sequencer;
  `uvm_component_utils(virtual_sequencer)
  core_A_sequencer seqr_A;
  core_B_sequencer seqr_B;

  function new(string name = "virtual_sequencer", uvm_component parent = null);
    super.new(name, parent);
  endfunction
endclass 