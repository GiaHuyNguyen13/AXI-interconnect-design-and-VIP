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

    case({m1_wr_en, m1_rd_en, m2_wr_en, m2_rd_en})
    4'b0001: begin
        // m2_rd_en is enabled
        fork
            m2_seq_rd.start(e0.m2.s0_rd);

            //s1_seq_wr.start(e0.s1.s0_wr);
            s1_seq_rd.start(e0.s1.s0_rd);
            //s2_seq_wr.start(e0.s2.s0_wr);
            s2_seq_rd.start(e0.s2.s0_rd);
        join_any
    end
    4'b0010: begin
        // m2_wr_en is enabled
        fork
            m2_seq_wr.start(e0.m2.s0_wr);

            s1_seq_wr.start(e0.s1.s0_wr);
            //s1_seq_rd.start(e0.s1.s0_rd);
            s2_seq_wr.start(e0.s2.s0_wr);
            //s2_seq_rd.start(e0.s2.s0_rd);
        join_any
    end
    4'b0011: begin
        // m2_wr_en and m2_rd_en are enabled
        fork
            m2_seq_wr.start(e0.m2.s0_wr);
            m2_seq_rd.start(e0.m2.s0_rd);

            s1_seq_wr.start(e0.s1.s0_wr);
            s1_seq_rd.start(e0.s1.s0_rd);
            s2_seq_wr.start(e0.s2.s0_wr);
            s2_seq_rd.start(e0.s2.s0_rd);
        join_any
    end
    4'b0100: begin
        // m1_rd_en is enabled
        fork
            m1_seq_rd.start(e0.m1.s0_rd);

            //s1_seq_wr.start(e0.s1.s0_wr);
            s1_seq_rd.start(e0.s1.s0_rd);
            //s2_seq_wr.start(e0.s2.s0_wr);
            s2_seq_rd.start(e0.s2.s0_rd);
        join_any
    end
    4'b0101: begin
        // m1_rd_en and m2_rd_en are enabled
        fork
            m1_seq_rd.start(e0.m1.s0_rd);
            m2_seq_rd.start(e0.m2.s0_rd);

            //s1_seq_wr.start(e0.s1.s0_wr);
            s1_seq_rd.start(e0.s1.s0_rd);
            //s2_seq_wr.start(e0.s2.s0_wr);
            s2_seq_rd.start(e0.s2.s0_rd);
        join_any
    end
    4'b0110: begin
        // m1_rd_en and m2_wr_en are enabled
        fork
            m1_seq_rd.start(e0.m1.s0_rd);
            m2_seq_wr.start(e0.m2.s0_wr);

            s1_seq_wr.start(e0.s1.s0_wr);
            s1_seq_rd.start(e0.s1.s0_rd);
            s2_seq_wr.start(e0.s2.s0_wr);
            s2_seq_rd.start(e0.s2.s0_rd);
        join_any
    end
    4'b0111: begin
        // m1_rd_en, m2_wr_en, and m2_rd_en are enabled
        fork
            m1_seq_rd.start(e0.m1.s0_rd);
            m2_seq_wr.start(e0.m2.s0_wr);
            m2_seq_rd.start(e0.m2.s0_rd);

            s1_seq_wr.start(e0.s1.s0_wr);
            s1_seq_rd.start(e0.s1.s0_rd);
            s2_seq_wr.start(e0.s2.s0_wr);
            s2_seq_rd.start(e0.s2.s0_rd);
        join_any
    end
    4'b1000: begin
        // m1_wr_en is enabled
        fork
            m1_seq_wr.start(e0.m1.s0_wr);

            s1_seq_wr.start(e0.s1.s0_wr);
            s2_seq_wr.start(e0.s2.s0_wr);
        join_any
    end
    4'b1001: begin
        // m1_wr_en and m2_rd_en are enabled
        fork
            m1_seq_wr.start(e0.m1.s0_wr);
            m2_seq_rd.start(e0.m2.s0_rd);

            s1_seq_wr.start(e0.s1.s0_wr);
            s1_seq_rd.start(e0.s1.s0_rd);
            s2_seq_wr.start(e0.s2.s0_wr);
            s2_seq_rd.start(e0.s2.s0_rd);
        join_any
    end
    4'b1010: begin
        // m1_wr_en and m2_wr_en are enabled
        fork
            m1_seq_wr.start(e0.m1.s0_wr);
            m2_seq_wr.start(e0.m2.s0_wr);

            s1_seq_wr.start(e0.s1.s0_wr);
            //s1_seq_rd.start(e0.s1.s0_rd);
            s2_seq_wr.start(e0.s2.s0_wr);
            //s2_seq_rd.start(e0.s2.s0_rd);
        join_any
    end
    4'b1011: begin
        // m1_wr_en, m2_wr_en, and m2_rd_en are enabled
        fork
            m1_seq_wr.start(e0.m1.s0_wr);
            m2_seq_wr.start(e0.m2.s0_wr);
            m2_seq_rd.start(e0.m2.s0_rd);

            s1_seq_wr.start(e0.s1.s0_wr);
            s1_seq_rd.start(e0.s1.s0_rd);
            s2_seq_wr.start(e0.s2.s0_wr);
            s2_seq_rd.start(e0.s2.s0_rd);
        join_any
    end
    4'b1100: begin
        // m1_wr_en and m1_rd_en are enabled
        fork
            m1_seq_wr.start(e0.m1.s0_wr);
            m1_seq_rd.start(e0.m1.s0_rd);

            s1_seq_wr.start(e0.s1.s0_wr);
            s1_seq_rd.start(e0.s1.s0_rd);
            s2_seq_wr.start(e0.s2.s0_wr);
            s2_seq_rd.start(e0.s2.s0_rd);
        join_any
    end
    4'b1101: begin
        // m1_wr_en, m1_rd_en and m2_rd_en are enabled
        fork
            m1_seq_wr.start(e0.m1.s0_wr);
            m1_seq_rd.start(e0.m1.s0_rd);
            m2_seq_rd.start(e0.m2.s0_rd);

            s1_seq_wr.start(e0.s1.s0_wr);
            s1_seq_rd.start(e0.s1.s0_rd);
            s2_seq_wr.start(e0.s2.s0_wr);
            s2_seq_rd.start(e0.s2.s0_rd);
        join_any
    end
    4'b1110: begin
        // m1_wr_en, m1_rd_en and m2_wr_en are enabled
        fork
            m1_seq_wr.start(e0.m1.s0_wr);
            m1_seq_rd.start(e0.m1.s0_rd);
            m2_seq_wr.start(e0.m2.s0_wr);

            s1_seq_wr.start(e0.s1.s0_wr);
            s1_seq_rd.start(e0.s1.s0_rd);
            s2_seq_wr.start(e0.s2.s0_wr);
            s2_seq_rd.start(e0.s2.s0_rd);
        join_any
    end
    4'b1111: begin
        // All enabled
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
    end
    default: begin
        // Default case: no sequences started if all enable flags are off
        $display("No sequences started, all enable flags are off.");
    end
endcase

    #200;
    phase.drop_objection(this);
  endtask

endclass