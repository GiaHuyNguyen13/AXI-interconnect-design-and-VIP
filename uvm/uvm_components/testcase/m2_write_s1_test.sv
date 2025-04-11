class m2_write_s1_test extends base_test;
  `uvm_component_utils(m2_write_s1_test)
  function new(string name="m2_write_s1_test.sv", uvm_component parent=null);
    super.new(name, parent);
  endfunction

  /****************CHANGE THESE PARAMETERS FOR EACH TESTCASE****************/

  // Select which operation is allow
  bit m1_wren = 0; // en = 1 to enable
  bit m1_rden = 0; // en = 1 to enable
  bit m2_wren = 1; // en = 1 to enable
  bit m2_rden = 0; // en = 1 to enable


  // Number of items for each operation
  bit [6:0] test_num_m2_wr = 10;

  // Select slave
  bit m1_sel_slv_wr = 0; // 0 for slave1  1 for slave2

  // Burst len for each operation
  bit [7:0] burst_len_m2_wr = 4; // 0 is 1 beat, 1 is 2 beat, ...

  /************************************************************************/

  // Number of slave item
  bit [6:0] test_num_sl_wr = test_num_m2_wr*2;
  
  
  virtual function void build_phase(uvm_phase phase);
    m1_wr_en = m1_wren; // en = 1 to enable
    m1_rd_en = m1_rden; // en = 1 to enable
    m2_wr_en = m2_wren; // en = 1 to enable
    m2_rd_en = m2_rden; // en = 1 to enable
    super.build_phase(phase);

    void'(m2_seq_wr.randomize() with { 
        num == test_num_m2_wr;
        len == burst_len_m2_wr;
        sel_slv == m1_sel_slv_wr;
    });


    void'(s1_seq_wr.randomize() with { 
        num == test_num_sl_wr; 
    });

    void'(s2_seq_wr.randomize() with { 
        num == test_num_sl_wr;     
    });
    
  endfunction
endclass