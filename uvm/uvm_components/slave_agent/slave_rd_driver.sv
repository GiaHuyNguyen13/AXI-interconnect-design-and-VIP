class slave_rd_driver extends uvm_driver #(slave_item);              
  `uvm_component_utils(slave_rd_driver)
  function new(string name = "slave_rd_driver", uvm_component parent=null);
    super.new(name, parent);
  endfunction
  
  virtual axi_interface axi_vif;
  centralized_memory_model mem;
  int delay = 0;
  
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
      @(posedge axi_vif.axi_arvalid) begin
        `uvm_info("DRV_Slave", $sformatf("Wait for item from sequencer"), UVM_HIGH)
        `uvm_info("DRV_Slave", $sformatf("Receive item"), UVM_HIGH)
        seq_item_port.get_next_item(m_item); // get next item
        // m_item.print();
        drive_item(m_item); // forward item to DUT through interface
      end
      
      `uvm_info("DRV_Slave", $sformatf("AXI item done"), UVM_HIGH)
      seq_item_port.item_done(); // item get done
    end
  endtask
  

  virtual task r_addr (slave_item m_item);
      // @(posedge axi_vif.clk);
          axi_vif.axi_arready <= 1'b1;
  endtask

  virtual task r_data (slave_item m_item);
  axi_vif.axi_rlast <= 1'b0;
    wait(axi_vif.axi_rready);
    // @(posedge axi_vif.clk)
          axi_vif.axi_rid <= axi_vif.axi_arid;
          axi_vif.axi_rvalid <= 1'b1;
          `uvm_info("DRV_Slave", $sformatf("HEREEEEE"), UVM_HIGH)
          for(int i = 0; i <= axi_vif.axi_arlen; i++) begin
            axi_vif.axi_rdata <= mem.read((axi_vif.axi_araddr%1000) + i);
            axi_vif.axi_rresp <= m_item.axi_rresp;
            if(i == axi_vif.axi_arlen) axi_vif.axi_rlast <= 1'b1;
            @(posedge axi_vif.clk);
          end
          axi_vif.axi_rlast <= 1'b0;
          // axi_vif.axi_rvalid <= 1'b0;
  endtask

//   virtual task w_addr (slave_item m_item);
//     @(posedge axi_vif.clk);
//     // if (axi_vif.axi_awvalid) begin // Write operation
//         axi_vif.axi_awready <= 1'b1;
//     // end
// endtask

// virtual task w_data (slave_item m_item);
//     axi_vif.axi_wready <= 1'b1;
//     wait(axi_vif.axi_wlast);
//     axi_vif.axi_bresp <= m_item.axi_bresp;
//     axi_vif.axi_bid <= m_item.axi_awid;
//     axi_vif.axi_bvalid <= 1'b1;
//     @(posedge axi_vif.clk);
//     axi_vif.axi_bresp <= 2'b00;
//     axi_vif.axi_bid <= 8'b0000_0000;
//     axi_vif.axi_bvalid <= 1'b0;
// endtask

virtual task drive_item (slave_item m_item);
  wait(!axi_vif.rst) begin
    fork
    r_addr(m_item);
    r_data(m_item);
    join
  end
endtask

endclass