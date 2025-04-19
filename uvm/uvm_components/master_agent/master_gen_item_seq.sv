class master_gen_item_seq extends uvm_sequence;
  `uvm_object_utils(master_gen_item_seq)
  function new(string name="master_gen_item_seq");
    super.new(name);
  endfunction

  rand int num;
  rand bit op;
  rand bit [7:0] len;
  rand bit sel_slv;
  rand bit slv_rand;
  rand bit bl_rand;
  rand bit equal;
  // integer op  = 1;
  // integer len = 4;
  // integer num = 3;
  constraint c_slv_rand {
      soft slv_rand == 0;
   }

   constraint c_len {
      soft bl_rand == 0;
   }

   constraint c_equal {
      soft equal == 0;
   }

  virtual task body();
    for (int i = 1; i <= num; i ++) begin
    	master_item m_item = master_item::type_id::create("m_item");
    	start_item(m_item);
    	void'(m_item.randomize() with {
        operation == op;
        if(!bl_rand){
        axi_awlen == len;
        axi_arlen == len;
        }
        sel_slave == sel_slv;
        rand_slv == slv_rand;
        burst_len_rand == bl_rand;
        equal_corner == equal;

      });
      `uvm_info("burst_test", $sformatf("I'm here, %0d", i), UVM_HIGH);
      finish_item(m_item);
    end
    `uvm_info("SEQ_Master", $sformatf("Done generation of %0d items",num), UVM_LOW)
  endtask
endclass