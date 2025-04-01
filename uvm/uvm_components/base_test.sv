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

  bit m1_wr_en; // en = 1 to enable
  bit m1_rd_en; // en = 1 to enable
  bit m2_wr_en; // en = 1 to enable
  bit m2_rd_en; // en = 1 to enable
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    // Create the environment
    e0 = env::type_id::create("e0", this);

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
    `uvm_info("INFO", $sformatf("m1_wr_en: %b, m1_rd_en: %b, m2_wr_en: %b, m2_rd_en: %b", 
                           m1_wr_en, m1_rd_en, m2_wr_en, m2_rd_en), UVM_LOW)

    fork
       // if(m1_wr_en) m1_seq_wr.start(e0.m1.s0_wr);
       if(m1_rd_en) m1_seq_rd.start(e0.m1.s0_rd);
       // if(m2_wr_en) m2_seq_wr.start(e0.m2.s0_wr);
       // if(m2_rd_en) m2_seq_rd.start(e0.m2.s0_rd);

       s1_seq_wr.start(e0.s1.s0_wr);
       s1_seq_rd.start(e0.s1.s0_rd);
       s2_seq_wr.start(e0.s2.s0_wr);
       s2_seq_rd.start(e0.s2.s0_rd);
    join_any
    #200;
    phase.drop_objection(this);
  endtask

endclass