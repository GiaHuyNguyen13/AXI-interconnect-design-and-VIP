class slave_agent extends uvm_agent;
  `uvm_component_utils(slave_agent)
  function new(string name="slave_agent", uvm_component parent=null);
    super.new(name, parent);
  endfunction
  
  slave_rd_driver 		rd0; 		// Driver handle
  slave_wr_driver     wd0;    // Driver handle
  slave_monitor 		m0; 		// Monitor handle
  uvm_sequencer #(slave_item)	s0_wr; 	// Sequencer Handle
  uvm_sequencer #(slave_item) s0_rd;  // Sequencer Handle
  virtual axi_interface axi_if;
  centralized_memory_model mem;

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    s0_wr = uvm_sequencer#(slave_item)::type_id::create("s0_wr", this);
    s0_rd = uvm_sequencer#(slave_item)::type_id::create("s0_rd", this);
    rd0 = slave_rd_driver::type_id::create("rd0", this);
    wd0 = slave_wr_driver::type_id::create("wd0", this);
    m0 = slave_monitor::type_id::create("m0", this);

    void'(uvm_config_db#(centralized_memory_model)::get(this, "", "mem", mem));
    uvm_config_db#(centralized_memory_model)::set(this, "*", "passdown_mem", mem);
    
    void'(uvm_config_db#(virtual axi_interface)::get(this, "", "axi_if", axi_if));
    uvm_config_db#(virtual axi_interface)::set(this, "*", "interface", axi_if);
  endfunction
  
  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    rd0.seq_item_port.connect(s0_rd.seq_item_export);
    wd0.seq_item_port.connect(s0_wr.seq_item_export);
  endfunction

endclass