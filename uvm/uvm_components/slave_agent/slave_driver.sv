class slave_driver extends uvm_driver #(slave_item);              
  `uvm_component_utils(slave_driver)
  function new(string name = "slave_driver", uvm_component parent=null);
    super.new(name, parent);
  endfunction
  
  virtual axi_interface axi_vif;
  centralized_memory_model mem;
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(virtual axi_interface)::get(this, "", "interface", axi_vif))
      `uvm_fatal("DRV", "Could not get axi_vif")
    if (!uvm_config_db#(centralized_memory_model)::get(this, "*", "passdown_mem", mem))
      `uvm_fatal("CONFIG_ERR", "Could not get centralized memory from config DB.");
  endfunction
  
  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
    forever begin
      slave_item m_item;
      `uvm_info("DRV_Slave", $sformatf("Wait for item from sequencer"), UVM_HIGH)
      seq_item_port.get_next_item(m_item); // get next item
      // m_item.print();
      drive_item(m_item); // forward item to DUT through interface
      `uvm_info("DRV_Slave", $sformatf("AXI item done"), UVM_HIGH)
      seq_item_port.item_done(); // item get done
    end
  endtask
  

  virtual task r_addr (slave_item m_item);
      @(posedge axi_vif.clk);
      // if (axi_vif.axi_arvalid) begin // Read operation
          axi_vif.axi_arready <= 1'b1;
      // end
  endtask

  virtual task r_data (slave_item m_item);
      @(posedge axi_vif.clk);
      if (axi_vif.axi_rready) begin // Read operation
          axi_vif.axi_rid <= axi_vif.axi_arid;
          axi_vif.axi_rvalid <= 1'b1;
          for(int i = 0; i <= axi_vif.axi_arlen; i++) begin
            axi_vif.axi_rdata <= mem.read(axi_vif.axi_araddr + i);
            axi_vif.axi_rresp <= 2'b00;
            if(i == axi_vif.axi_arlen) axi_vif.axi_rlast <= 1'b1;
            @(posedge axi_vif.clk);
          end
          axi_vif.axi_rlast <= 1'b0;
          axi_vif.axi_rvalid <= 1'b0;
      end
  endtask

  virtual task w_addr (slave_item m_item);
    @(posedge axi_vif.clk);
    // if (axi_vif.axi_awvalid) begin // Write operation
        axi_vif.axi_awready <= 1'b1;
    // end
endtask

virtual task w_data (slave_item m_item);
    axi_vif.axi_wready <= 1'b1;
    @(negedge axi_vif.axi_wlast);
    axi_vif.axi_bresp <= m_item.axi_bresp;
    axi_vif.axi_bid <= m_item.axi_awid;
    @(posedge axi_vif.clk);
    axi_vif.axi_bresp <= 2'b00;
    axi_vif.axi_bid <= 8'b0000_0000;
endtask

virtual task drive_item (slave_item m_item);
  wait(!axi_vif.rst) begin
    fork
    r_addr(m_item);
    r_data(m_item);
    // join

    // fork
    axi_vif.axi_bready <= 1'b1; 
    w_addr(m_item);
    w_data(m_item);
    join
  end
endtask

endclass