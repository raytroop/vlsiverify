class core_A_seq extends uvm_sequence #(seq_item);
  seq_item req;
  `uvm_object_utils(core_A_seq)
  
  function new (string name = "core_A_seq");
    super.new(name);
  endfunction
  
  task body();
    `uvm_info(get_type_name(), "core_A_seq: Inside Body", UVM_LOW);
    req = seq_item::type_id::create("req");
    req.core = CORE_A;
    wait_for_grant();
    assert(req.randomize());
    send_request(req);
    wait_for_item_done();
  endtask
endclass


class core_B_seq extends uvm_sequence #(seq_item);
  seq_item req;
  `uvm_object_utils(core_B_seq)
  
  function new (string name = "core_B_seq");
    super.new(name);
  endfunction
  
  task body();
    `uvm_info(get_type_name(), "core_B_seq: Inside Body", UVM_LOW);
    req = seq_item::type_id::create("req");
    req.core = CORE_B;
    wait_for_grant();
    assert(req.randomize());
    send_request(req);
    wait_for_item_done();
  endtask
endclass

// create a virtual sequence which holds core_A_seq and core_B_seq

class virtual_seq extends uvm_sequence #(seq_item);
  core_A_seq Aseq;
  core_B_seq Bseq;  
  
  `uvm_object_utils(virtual_seq)
  `uvm_declare_p_sequencer(virtual_sequencer)
  
  function new (string name = "virtual_seq");
    super.new(name);
  endfunction
  
  task body();
    `uvm_info(get_type_name(), "virtual_seq: Inside Body", UVM_LOW);
    Aseq = core_A_seq::type_id::create("Aseq");
    Bseq = core_B_seq::type_id::create("Bseq");
    
    Aseq.start(p_sequencer.seqr_A);
    Bseq.start(p_sequencer.seqr_B);
  endtask
endclass
