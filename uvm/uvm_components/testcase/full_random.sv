class full_random extends base_test;
  `uvm_component_utils(full_random)
  function new(string name="full_random", uvm_component parent=null);
    super.new(name, parent);
  endfunction

  /****************CHANGE THESE PARAMETERS FOR EACH TESTCASE****************/

  // Select which operation is allow
  bit m1_wren = 1; // en = 1 to enable
  bit m1_rden = 1; // en = 1 to enable
  bit m2_wren = 1; // en = 1 to enable
  bit m2_rden = 1; // en = 1 to enable


  // Number of items for each operation
  int test_num_m1_wr = 200;
  int test_num_m1_rd = 300;
  int test_num_m2_wr = 400;
  int test_num_m2_rd = 500;

  bit sel_slv1_rd = 0; // 0 for slave1  1 for slave2
  bit sel_slv1_wr = 0; // 0 for slave1  1 for slave2
  bit sel_slv2_rd = 0; // 0 for slave1  1 for slave2
  bit sel_slv2_wr = 0; // 0 for slave1  1 for slave2
  bit rand_slv = 1;

  // Burst len for each operation
  bit [7:0] burst_len_m1_wr = 20; // 0 is 1 beat, 1 is 2 beat, ...
  bit [7:0] burst_len_m1_rd = 30; // 0 is 1 beat, 1 is 2 beat, ...
  bit [7:0] burst_len_m2_wr = 40; // 0 is 1 beat, 1 is 2 beat, ...
  bit [7:0] burst_len_m2_rd = 50; // 0 is 1 beat, 1 is 2 beat, ...

  /************************************************************************/

  // Number of slave item
  int test_num_sl_wr = (test_num_m1_wr + test_num_m2_wr)*2;
  int test_num_sl_rd = (test_num_m1_rd + test_num_m2_rd)*2;  
  
  
  virtual function void build_phase(uvm_phase phase);
    m1_wr_en = m1_wren; // en = 1 to enable
    m1_rd_en = m1_rden; // en = 1 to enable
    m2_wr_en = m2_wren; // en = 1 to enable
    m2_rd_en = m2_rden; // en = 1 to enable
    sel_slv1_rd_bt = sel_slv1_rd;
    sel_slv1_wr_bt = sel_slv1_wr;
    sel_slv2_rd_bt = sel_slv2_rd;
    sel_slv2_wr_bt = sel_slv2_wr;
    super.build_phase(phase);

    void'(m1_seq_wr.randomize() with { 
        num == test_num_m1_wr;
        len == burst_len_m1_wr;
        // sel_slv == sel_slv1;
        slv_rand == rand_slv;
    });

    void'(m1_seq_rd.randomize() with { 
        num == test_num_m1_rd;
        len == burst_len_m1_rd;
        // sel_slv == sel_slv1;
        slv_rand == rand_slv;
    });


    void'(m2_seq_wr.randomize() with { 
        num == test_num_m2_wr;
        len == burst_len_m2_wr;
        // sel_slv == sel_slv2;
        slv_rand == rand_slv;
    });

    void'(m2_seq_rd.randomize() with { 
        num == test_num_m2_rd;
        len == burst_len_m2_rd;
        // sel_slv == sel_slv2;
        slv_rand == rand_slv;
    });


    void'(s1_seq_wr.randomize() with { 
        num == test_num_sl_wr; 
    });

    void'(s1_seq_rd.randomize() with { 
        num == test_num_sl_rd;
    });

    void'(s2_seq_wr.randomize() with { 
        num == test_num_sl_wr;       
    });
    
    void'(s2_seq_rd.randomize() with { 
        num == test_num_sl_rd;     
    });
    
  endfunction
endclass