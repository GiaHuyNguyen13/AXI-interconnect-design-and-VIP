class burst_test extends base_test;
  `uvm_component_utils(burst_test)
  function new(string name="burst_test", uvm_component parent=null);
    super.new(name, parent);
  endfunction

  // bit operation = 1; // 0  for read, 1 for write
  bit [6:0] test_num_m1_wr = 2;
  bit [6:0] test_num_m1_rd = 0;
  bit [6:0] test_num_m2_wr = 2;
  bit [6:0] test_num_m2_rd = 0;

  bit [7:0] burst_len_m1_wr = 3; // 0 is 1 beat, 1 is 2 beat, ...
  bit [7:0] burst_len_m1_rd = 3; // 0 is 1 beat, 1 is 2 beat, ...
  bit [7:0] burst_len_m2_wr = 3; // 0 is 1 beat, 1 is 2 beat, ...
  bit [7:0] burst_len_m2_rd = 3; // 0 is 1 beat, 1 is 2 beat, ...

  bit [6:0] test_num_sl_wr = test_num_m1_wr + test_num_m2_wr;
  bit [6:0] test_num_sl_rd = test_num_m1_rd + test_num_m2_rd;  
  
  
  virtual function void build_phase(uvm_phase phase);
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