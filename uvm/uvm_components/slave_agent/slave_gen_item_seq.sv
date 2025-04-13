class slave_gen_item_seq extends uvm_sequence;
  `uvm_object_utils(slave_gen_item_seq)
  function new(string name="slave_gen_item_seq");
    super.new(name);
  endfunction

  rand int num;
  rand bit op;
  // rand bit [7:0] len;
  // bit op = 0;
  // bit [6:0] num = 3;

  virtual task body();
  `uvm_info("burst_test", $sformatf("I'm here slave, %0d", num), UVM_HIGH);
    for (int i = 1; i <= num; i ++) begin
    	slave_item m_item = slave_item::type_id::create("m_item");
    	start_item(m_item);
    	void'(m_item.randomize() with {
        operation == op;
      });
      finish_item(m_item);
    end
    `uvm_info("SEQ_Slave", $sformatf("Done generation of %0d items",num), UVM_LOW)
  endtask
endclass