class base_test extends uvm_test;
  `uvm_component_utils(base_test)
  function new(string name = "base_test", uvm_component parent=null);
    super.new(name, parent);
  endfunction
  
  env  				e0;
  master_gen_item_seq 		m1_seq_wr;
  master_gen_item_seq     m1_seq_rd;
  master_gen_item_seq     m2_seq_wr;
  master_gen_item_seq     m2_seq_rd;

  slave_gen_item_seq      s1_seq_wr;
  slave_gen_item_seq      s1_seq_rd;
  slave_gen_item_seq      s2_seq_wr;
  slave_gen_item_seq      s2_seq_rd;
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    // Create the environment
    e0 = env::type_id::create("e0", this);
    
    // Get virtual IF handle from top level and pass it to everything
    // in env level
    // if (!uvm_config_db#(virtual axi_interface)::get(this, "", "axi_interface", axi_vif))
    //   `uvm_fatal("TEST", "Did not get axi_vif")
    // if (!uvm_config_db#(virtual axil_interface)::get(this, "", "axil_interface", axil_vif))
    //   `uvm_fatal("TEST", "Did not get axil_vif")

    // uvm_config_db#(virtual axi_interface)::set(this, "e0.*", "axi_interface", axi_vif);
    // uvm_config_db#(virtual axil_interface)::set(this, "e0.*", "axil_interface", axil_vif);

    // Create sequence and randomize it
    m1_seq_wr = master_gen_item_seq::type_id::create("m1_seq_wr");
    void'(m1_seq_wr.randomize());
    m1_seq_rd = master_gen_item_seq::type_id::create("m1_seq_rd");
    void'(m1_seq_rd.randomize());
    
    m2_seq_wr = master_gen_item_seq::type_id::create("m2_seq_wr");
    void'(m2_seq_wr.randomize());
    m2_seq_rd = master_gen_item_seq::type_id::create("m2_seq_rd");
    void'(m2_seq_rd.randomize());

    s1_seq_wr = slave_gen_item_seq::type_id::create("s1_seq_wr");
    void'(s1_seq_wr.randomize());
    s1_seq_rd = slave_gen_item_seq::type_id::create("s1_seq_rd");
    void'(s1_seq_rd.randomize());
    s2_seq_wr = slave_gen_item_seq::type_id::create("s2_seq_wr");
    void'(s2_seq_wr.randomize());
    s2_seq_rd = slave_gen_item_seq::type_id::create("s2_seq_rd");
    void'(s2_seq_rd.randomize());
  endfunction
  
  virtual task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    fork
       m1_seq_wr.start(e0.m1.s0_wr);
       m1_seq_rd.start(e0.m1.s0_rd);

       m2_seq_wr.start(e0.m2.s0_wr);
       m2_seq_rd.start(e0.m2.s0_rd);

       s1_seq_wr.start(e0.s1.s0_wr);
       s1_seq_rd.start(e0.s1.s0_rd);
       s2_seq_wr.start(e0.s2.s0_wr);
       s2_seq_rd.start(e0.s2.s0_rd);
    join_any
    #200;
    phase.drop_objection(this);
  endtask

endclass