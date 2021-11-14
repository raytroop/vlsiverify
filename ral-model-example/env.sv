class env extends uvm_env;
  `uvm_component_utils(env)
  agent agt;
  reg_axi_adapter adapter;
  RegModel_SFR reg_model;
  function new(string name = "env", uvm_component parent = null);
    super.new(name, parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    agt = agent::type_id::create("agt", this);
    adapter = reg_axi_adapter::type_id::create("adapter");
    reg_model = RegModel_SFR::type_id::create("reg_model");
    reg_model.build();
    reg_model.reset();
    reg_model.lock_model();
    reg_model.print();
    
    uvm_config_db#(RegModel_SFR)::set(uvm_root::get(), "*", "reg_model", reg_model);
  endfunction
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    reg_model.default_map.set_sequencer( .sequencer(agt.seqr), .adapter(adapter) );
    reg_model.default_map.set_base_addr('h0);        
    //regmodel.add_hdl_path("tb_top.DUT");
  endfunction
endclass