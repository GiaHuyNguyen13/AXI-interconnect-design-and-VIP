class master_agent extends uvm_agent;
  `uvm_component_utils(master_agent)
  function new(string name="master_agent", uvm_component parent=null);
    super.new(name, parent);
  endfunction
  
  master_driver 		d0; 		// Driver handle
  master_monitor 		m0; 		// Monitor handle
  uvm_sequencer #(master_item)	s0; 		// Sequencer Handle

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    s0 = uvm_sequencer#(master_item)::type_id::create("s0", this);
    d0 = master_driver::type_id::create("d0", this);
    m0 = master_monitor::type_id::create("m0", this);
  endfunction
  
  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    d0.seq_item_port.connect(s0.seq_item_export);
  endfunction

endclass