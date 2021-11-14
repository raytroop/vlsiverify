class myseq extends uvm_sequence #(seq_item);
  seq_item req;
  `uvm_object_utils(myseq)
  
  function new (string name = "myseq");
    super.new(name);
  endfunction

  task body();
    `uvm_info(get_type_name(), "Inside body task", UVM_LOW);

    repeat(3) begin 
      req = seq_item::type_id::create("req");
      wait_for_grant();
      assert(req.randomize());
      send_request(req);
      wait_for_item_done();
      `uvm_info(get_type_name(), "Inside body task and finish one item", UVM_LOW);
    end

    `uvm_info(get_type_name(), "Completed body task", UVM_LOW);
  endtask
endclass
