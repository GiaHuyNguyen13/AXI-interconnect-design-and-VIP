class master_wr_driver extends uvm_driver #(master_item);              
  `uvm_component_utils(master_wr_driver)
  function new(string name = "master_wr_driver", uvm_component parent=null);
    super.new(name, parent);
  endfunction
  
  virtual axi_interface axi_vif;
  centralized_memory_model mem;
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(virtual axi_interface)::get(this, "", "interface", axi_vif))
      `uvm_fatal("DRV", "Could not get axi_vif")
    if (!uvm_config_db#(centralized_memory_model)::get(this, "", "passdown_mem", mem))
      `uvm_fatal("CONFIG_ERR", "Could not get centralized memory from config DB.");
  endfunction
  
  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
    forever begin
      master_item m_item;
      // `uvm_info("DRV_Master", $sformatf("%0d", seq_item_port.has_do_available()), UVM_HIGH)
      // if(seq_item_port.has_do_available()) begin
        `uvm_info("DRV_Master", $sformatf("Wait for item from sequencer"), UVM_HIGH)
        seq_item_port.get_next_item(m_item); // get next item

        drive_item(m_item); // forward item to DUT through interface
        `uvm_info("DRV_Master", $sformatf("I'm here working"), UVM_LOW);
        `uvm_info("DRV_Master", $sformatf("AXI item done"), UVM_HIGH)
        seq_item_port.item_done(); // item get done
      // end
    end
  endtask

  virtual task w_addr (master_item m_item);
    @(posedge axi_vif.clk);
        axi_vif.axi_awid    <= m_item.axi_awid;
        axi_vif.axi_awaddr  <= m_item.axi_awaddr;
        axi_vif.axi_awlen   <= m_item.axi_awlen;
        axi_vif.axi_awsize  <= 3'b010; //m_item.axi_awsize;
        axi_vif.axi_awburst <= m_item.axi_awburst;
        axi_vif.axi_awprot  <= m_item.axi_awprot;
        axi_vif.axi_awlock  <= m_item.axi_awlock;
        axi_vif.axi_awcache <= m_item.axi_awcache;
        axi_vif.axi_awvalid <= 1'b1;
        // `uvm_info("DRV_Master", $sformatf("Start waiting"), UVM_HIGH)
        // wait(axi_vif.axi_awready);
        // `uvm_info("DRV_Master", $sformatf("Done waiting"), UVM_HIGH)
          wait(axi_vif.axi_wlast == 1'b1)
          @(negedge axi_vif.axi_wlast);
          axi_vif.axi_awvalid <= 1'b0;
endtask

virtual task w_data (master_item m_item);
    integer len = m_item.axi_awlen + 1;
    wait(axi_vif.axi_wready)
        axi_vif.axi_bready <= 1'b1;
        for (integer i=0; i<len; i++) begin
          // @(posedge axi_vif.clk);
          axi_vif.axi_wdata   <= mem.read(m_item.axi_awaddr + i);
          axi_vif.axi_wstrb   <= m_item.axi_wstrb;
          axi_vif.axi_wlast   <= (i == len - 1) ? 1:0;
          axi_vif.axi_wvalid  <= m_item.axi_wvalid;
          @(posedge axi_vif.clk);
          axi_vif.axi_wvalid  <= 1'b0;
          axi_vif.axi_wlast <= 0;
    end
endtask

virtual task drive_item (master_item m_item);
  wait(!axi_vif.rst) begin

    fork
    axi_vif.axi_bready <= 1'b1; 
    w_addr(m_item);
    w_data(m_item);
    join
  end
endtask

endclass