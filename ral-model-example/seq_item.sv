class seq_item extends uvm_sequence_item;
  rand bit [31:0] addr;
  rand bit [31:0] data;
  rand bit rd_or_wr; // rd_or_wr = 0 (Write)
                     // rd_or_wr = 1 (Read)
  
  function new(string name = "seq_item");
    super.new(name);
  endfunction
  
  `uvm_object_utils_begin(seq_item)
    `uvm_field_int(addr,     UVM_ALL_ON)
    `uvm_field_int(data,     UVM_ALL_ON)
    `uvm_field_int(rd_or_wr, UVM_ALL_ON)
  `uvm_object_utils_end
  
  constraint addr_c {addr inside {'h0, 'h4, 'h8, 'hc};}
  constraint rd_or_wr_c {rd_or_wr dist {1:=30, 0:=70};} 
endclass



