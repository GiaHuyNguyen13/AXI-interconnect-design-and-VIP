class master_gen_item_seq extends uvm_sequence;
  `uvm_object_utils(master_gen_item_seq)
  function new(string name="master_gen_item_seq");
    super.new(name);
  endfunction

  rand bit [6:0] num;
  rand bit op;
  rand bit [7:0] len;
  // num = 1;

  virtual task body();
    for (int i = 0; i < num; i ++) begin
    	master_item m_item = master_item::type_id::create("m_item");
    	start_item(m_item);
    	m_item.randomize() with {
        operation == op;
        axi_awlen == len;
        axi_arlen == len;
      };
      finish_item(m_item);
    end
    `uvm_info("SEQ", $sformatf("Done generation of %0d items",num), UVM_LOW)
  endtask
endclass