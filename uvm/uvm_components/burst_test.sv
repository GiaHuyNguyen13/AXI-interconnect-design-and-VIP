class burst_test extends base_test;
  `uvm_component_utils(burst_test)
  function new(string name="burst_test", uvm_component parent=null);
    super.new(name, parent);
  endfunction

  bit operation = 1; // 0  for read, 1 for write
  bit [6:0] test_num = 3;
  bit [7:0] burst_len = 4; // 0 is 1 beat, 1 is 2 beat, ...
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    uvm_config_db#(bit[7:0])::set(this, "*", "burst_len", burst_len);
    `uvm_info("burst_test", $sformatf("I'm here"), UVM_LOW);
    m1_seq.randomize() with { 
        num == 3;//test_num;
        op  == 1;//operation;
        len == burst_len;
    };

    m2_seq.randomize() with { 
        num == 3;//test_num;
        op  == 0;//operation;
        len == burst_len;
    };

    s1_seq_wr.randomize() with { 
        num == 3;//test_num;
        op  == operation;
    };

    s1_seq_rd.randomize() with { 
        num == 3;//test_num;
        op  == operation;
    };

    s2_seq_wr.randomize() with { 
        num == 3;//test_num;
        op  == operation;
    };
    
    s2_seq_rd.randomize() with { 
        num == 3;//test_num;
        op  == operation;
    };
    
  endfunction
endclass