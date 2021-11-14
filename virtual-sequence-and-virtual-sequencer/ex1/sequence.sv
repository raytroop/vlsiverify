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