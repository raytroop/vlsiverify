// Code your testbench here
// or browse Examples
`include "uvm_macros.svh"
import uvm_pkg::*;
typedef enum {CORE_A, CORE_B} core_type;
`include "seq_item.sv"
`include "sequencer.sv"
`include "driver.sv"
`include "agent.sv"
`include "env.sv"
`include "sequence.sv"

class base_test extends uvm_test;
  env env_o;
   
  virtual_seq v_seq;
 
  `uvm_component_utils(base_test)
  
  function new(string name = "base_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env_o = env::type_id::create("env_o", this);
  endfunction
 
  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    v_seq = virtual_seq::type_id::create("v_seq");
    
    // Assign sequencer handle from hierarchy.
    v_seq.seqr_A = env_o.agt_A.seqr_A;
    v_seq.seqr_B = env_o.agt_B.seqr_B;
    
    v_seq.start(null);    
    
    phase.drop_objection(this);
  endtask
endclass

module tb_top;
  initial begin
    run_test("base_test");
  end
endmodule