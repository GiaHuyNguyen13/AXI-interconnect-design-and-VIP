// `include "central_mem.sv"
class env extends uvm_env;
  `uvm_component_utils(env)
  function new(string name="env", uvm_component parent=null);
    super.new(name, parent);
  endfunction
  
  master_agent 		m1, m2; 		// Agent handle
  slave_agent    s1, s2;
  scoreboard	sb0; 		// Scoreboard handle
  centralized_memory_model mem;
    
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    m1 = master_agent::type_id::create("m1", this);
    m2 = master_agent::type_id::create("m2", this);
    s1 = slave_agent::type_id::create("s1", this);
    s2 = slave_agent::type_id::create("s2", this);

    sb0 = scoreboard::type_id::create("sb0", this);
    mem = new();
    uvm_config_db#(centralized_memory_model)::set(this, "*", "central_memory", mem);
  endfunction
  
  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    m1.m0.m1_mon_ap.connect(sb0.m1_analysis_imp);
    m2.m0.m2_mon_ap.connect(sb0.m2_analysis_imp);
    s1.m0.s1_mon_ap.connect(sb0.s1_analysis_imp);
    s2.m0.s2_mon_ap.connect(sb0.s2_analysis_imp);
  endfunction
endclass