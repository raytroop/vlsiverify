class base_test extends uvm_test;
  env env_o;
  myseq seq[5];

  `uvm_component_utils(base_test)
  
  function new(string name = "base_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env_o = env::type_id::create("env_o", this);
  endfunction
  
  virtual task cfg_arb_mode;
  endtask
  
  task run_phase(uvm_phase phase);
    string s_name;
    super.run_phase(phase);
    phase.raise_objection(this);
    cfg_arb_mode();
    `uvm_info(get_name, $sformatf("Arbitration mode = %s", env_o.agt.seqr.get_arbitration()), UVM_LOW);
    foreach(seq[i]) begin
      automatic int j = i;
      fork
      begin
        s_name = $sformatf("seq[%0d]", j);
        seq[j] = myseq::type_id::create(s_name);    
        seq[j].start(env_o.agt.seqr, .this_priority((j+1)*100)); // priority is mentioned as 100, 200, 300, 400, 500 for j = 0,1,2,3,4
      end
      join_none
    end
    wait fork;
    
    phase.drop_objection(this);
  endtask
endclass
      
/*
Arbitration modes
1. UVM_SEQ_ARB_FIFO
2. UVM_SEQ_ARB_WEIGHTED
3. UVM_SEQ_ARB_RANDOM
4. UVM_SEQ_ARB_STRICT_FIFO
5. UVM_SEQ_ARB_STRICT_RANDOM
6. UVM_SEQ_ARB_USER
*/

class seq_arb_fifo_test extends base_test;
  `uvm_component_utils(seq_arb_fifo_test)
    
  function new(string name = "seq_arb_fifo_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction
  
  task cfg_arb_mode;
    env_o.agt.seqr.set_arbitration(UVM_SEQ_ARB_FIFO);
  endtask
endclass
      
class seq_arb_weighted_test extends base_test;
  `uvm_component_utils(seq_arb_weighted_test)
    
  function new(string name = "seq_arb_weighted_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction
  
  task cfg_arb_mode;
    env_o.agt.seqr.set_arbitration(UVM_SEQ_ARB_WEIGHTED);
  endtask
endclass

class seq_arb_random_test extends base_test;
  `uvm_component_utils(seq_arb_random_test)
    
  function new(string name = "seq_arb_random_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction
  
  task cfg_arb_mode;
    env_o.agt.seqr.set_arbitration(UVM_SEQ_ARB_RANDOM);
  endtask
endclass

class seq_arb_strict_fifo_test extends base_test;
  `uvm_component_utils(seq_arb_strict_fifo_test)
    
  function new(string name = "seq_arb_strict_fifo_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction
  
  task cfg_arb_mode;
    env_o.agt.seqr.set_arbitration(UVM_SEQ_ARB_STRICT_FIFO);
  endtask
endclass

class seq_arb_strict_random_test extends base_test;
  `uvm_component_utils(seq_arb_strict_random_test)
    
  function new(string name = "seq_arb_strict_random_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction
  
  task cfg_arb_mode;
    env_o.agt.seqr.set_arbitration(UVM_SEQ_ARB_STRICT_RANDOM);
  endtask
endclass

