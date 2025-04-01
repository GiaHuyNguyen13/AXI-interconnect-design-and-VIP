class burst_test extends base_test;
  `uvm_component_utils(burst_test)
  function new(string name="burst_test", uvm_component parent=null);
    super.new(name, parent);
  endfunction

  bit [6:0] test_num_m1_wr = 2;
  bit [6:0] test_num_m1_rd = 2;
  bit [6:0] test_num_m2_wr = 2;
  bit [6:0] test_num_m2_rd = 2;

  bit [7:0] burst_len_m1_wr = 4; // 0 is 1 beat, 1 is 2 beat, ...
  bit [7:0] burst_len_m1_rd = 4; // 0 is 1 beat, 1 is 2 beat, ...
  bit [7:0] burst_len_m2_wr = 4; // 0 is 1 beat, 1 is 2 beat, ...
  bit [7:0] burst_len_m2_rd = 4; // 0 is 1 beat, 1 is 2 beat, ...

  bit [6:0] test_num_sl_wr = 4;//test_num_m1_wr + test_num_m2_wr;
  bit [6:0] test_num_sl_rd = 4;//test_num_m1_rd + test_num_m2_rd;  
  
  
  virtual function void build_phase(uvm_phase phase);
    m1_wr_en = 0; // en = 1 to enable
    m1_rd_en = 1; // en = 1 to enable
    m2_wr_en = 0; // en = 1 to enable
    m2_rd_en = 0; // en = 1 to enable
    super.build_phase(phase);

    m1_seq_wr.randomize() with { 
        num == test_num_m1_wr;
        //op  == operation;
        len == burst_len_m1_wr;
    };

    m1_seq_rd.randomize() with { 
        num == test_num_m1_rd;
        //op  == operation;
        len == burst_len_m1_rd;
    };


    m2_seq_wr.randomize() with { 
        num == test_num_m2_wr;
        //op  == operation;
        len == burst_len_m2_wr;
    };

    m2_seq_rd.randomize() with { 
        num == test_num_m2_rd;
        //op  == operation;
        len == burst_len_m2_rd;
    };


    s1_seq_wr.randomize() with { 
        num == test_num_sl_wr;//test_num;
        //op  == operation;
    };

    s1_seq_rd.randomize() with { 
        num == test_num_sl_rd;//test_num;
        //op  == operation;
    };

    s2_seq_wr.randomize() with { 
        num == test_num_sl_wr;//test_num;
        //op  == operation;
    };
    
    s2_seq_rd.randomize() with { 
        num == test_num_sl_rd;//test_num;
        //op  == operation;
    };
    
  endfunction
endclass