class env extends uvm_env;
  core_A_agent agt_A;
  core_B_agent agt_B;
  
  virtual_sequencer v_seqr;
  `uvm_component_utils(env)
  
  function new(string name = "env", uvm_component parent = null);
    super.new(name, parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    agt_A = core_A_agent::type_id::create("agt_A", this);
    agt_B = core_B_agent::type_id::create("agt_B", this);
    
    v_seqr = virtual_sequencer::type_id::create("v_seqr", this);
  endfunction
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    v_seqr.seqr_A = agt_A.seqr_A;
    v_seqr.seqr_B = agt_B.seqr_B;
  endfunction
endclass
