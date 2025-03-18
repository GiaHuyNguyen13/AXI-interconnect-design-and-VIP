class scoreboard extends uvm_scoreboard;
  `uvm_component_utils(scoreboard)
  `uvm_analysis_imp_decl(_m1)
  `uvm_analysis_imp_decl(_m2)
  `uvm_analysis_imp_decl(_s1)
  `uvm_analysis_imp_decl(_s2)
  function new(string name="scoreboard", uvm_component parent=null);
    super.new(name, parent);
  endfunction
  
  bit [31:0] S1_WIDTH;
  bit slave_num; // 0 for slave 1, 1 for slave 2
  uvm_analysis_imp_m1  #(master_item, scoreboard) m1_analysis_imp;
  uvm_analysis_imp_m2  #(master_item, scoreboard) m2_analysis_imp;
  uvm_analysis_imp_s1  #(slave_item, scoreboard)  s1_analysis_imp;
  uvm_analysis_imp_s2  #(slave_item, scoreboard)  s2_analysis_imp;

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    m1_analysis_imp = new("m1_analysis_imp", this);
    m2_analysis_imp = new("m2_analysis_imp", this);
    s1_analysis_imp = new("s1_analysis_imp", this);
    s2_analysis_imp = new("s2_analysis_imp", this);

    // if (!uvm_config_db#(centralized_memory_model)::get(this, "", "central_memory", mem))
    //   `uvm_fatal("CONFIG_ERR", "Could not get centralized memory from config DB.")
    if (!uvm_config_db#(bit[31:0])::get(this, "", "S1_WIDTH", S1_WIDTH))
      `uvm_fatal("CONFIG_ERR", "Could not get S1_WIDTH from config DB.")
  endfunction

  virtual function write_m1 (master_item m1_item);


  endfunction : write_m1


  virtual function write_m2 (master_item m2_item);
    

  endfunction : write_m2 


  virtual function write_s1 (master_item s1_item);
    

  endfunction : write_s1 


  virtual function write_s2 (master_item s2_item);
    

  endfunction : write_s2  

  
endclass
