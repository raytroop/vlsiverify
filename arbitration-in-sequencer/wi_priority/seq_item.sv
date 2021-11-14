class seq_item extends uvm_sequence_item;
  rand bit[15:0] addr;
  rand bit[15:0] data;
  `uvm_object_utils(seq_item)
  
  function new(string name = "seq_item");
    super.new(name);
  endfunction
  
endclass