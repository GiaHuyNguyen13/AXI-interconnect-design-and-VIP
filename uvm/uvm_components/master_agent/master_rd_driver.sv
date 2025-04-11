class master_rd_driver extends uvm_driver #(master_item);              
  `uvm_component_utils(master_rd_driver)
  function new(string name = "master_rd_driver", uvm_component parent=null);
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
      // if(seq_item_port.has_do_available()) begin
        `uvm_info("DRV_Master", $sformatf("Wait for item from sequencer"), UVM_HIGH)
        seq_item_port.get_next_item(m_item); // get next item
        drive_item(m_item); // forward item to DUT through interface
        `uvm_info("DRV_Master", $sformatf("AXI item done"), UVM_HIGH)
        seq_item_port.item_done(); // item get done
      // end
    end
  endtask
  

  virtual task r_addr (master_item m_item);
      @(posedge axi_vif.clk);
      if (!m_item.operation) begin // Read operation
          axi_vif.axi_arid    <= m_item.axi_arid;
          axi_vif.axi_araddr  <= m_item.axi_araddr;
          axi_vif.axi_arlen   <= m_item.axi_arlen;
          axi_vif.axi_arsize  <= 3'b010;
          axi_vif.axi_arburst <= m_item.axi_arburst;
          axi_vif.axi_arlock  <= m_item.axi_arlock;
          axi_vif.axi_arcache <= m_item.axi_arcache;
          axi_vif.axi_arprot  <= m_item.axi_arprot;
          axi_vif.axi_arvalid <= m_item.axi_arvalid;
          // wait(!axi_vif.axi_arready)
          // @(posedge axi_vif.axi_rlast);
          wait(axi_vif.axi_rlast == 1'b1)
          @(negedge axi_vif.axi_rlast);
          axi_vif.axi_arvalid <= 1'b0;
          `uvm_info("DRV_Master", $sformatf("Hgggggggggggggggggggggg"), UVM_HIGH)
      end
  endtask

  virtual task r_data (master_item m_item);
      @(posedge axi_vif.clk);
      if (!m_item.operation) begin // Read operation
          axi_vif.axi_rready <= m_item.axi_rready;
          // @(posedge axi_vif.axi_rlast);
          
          wait(axi_vif.axi_rlast == 1'b1)
          @(negedge axi_vif.axi_rlast);
          axi_vif.axi_rready <= 1'b0;
          `uvm_info("DRV_Master", $sformatf("HHHHHHHHHHHHHHHHHHHHHHHHHHHH"), UVM_HIGH)
      end
  endtask

//   virtual task w_addr (master_item m_item);
//     @(posedge axi_vif.clk);
//     if (m_item.operation) begin // Write operation
//         axi_vif.axi_awid    <= m_item.axi_awid;
//         axi_vif.axi_awaddr  <= m_item.axi_awaddr;
//         axi_vif.axi_awlen   <= m_item.axi_awlen;
//         axi_vif.axi_awsize  <= 3'b010; //m_item.axi_awsize;
//         axi_vif.axi_awburst <= m_item.axi_awburst;
//         axi_vif.axi_awprot  <= m_item.axi_awprot;
//         axi_vif.axi_awlock  <= m_item.axi_awlock;
//         axi_vif.axi_awcache <= m_item.axi_awcache;
//         `uvm_info("DRV_Master", $sformatf("Start waiting"), UVM_HIGH)
//         wait(axi_vif.axi_awready);
//         `uvm_info("DRV_Master", $sformatf("Done waiting"), UVM_HIGH)
//         axi_vif.axi_awvalid <= m_item.axi_awvalid;
//         wait(!axi_vif.axi_awready);
//         axi_vif.axi_awvalid <= 1'b0;
//     end
// endtask

// virtual task w_data (master_item m_item);
//     integer len = m_item.axi_awlen + 1;
//     wait(axi_vif.axi_wready)
//     if (m_item.operation) begin // Write operation
//         axi_vif.axi_bready <= 1'b1;
//         for (integer i=0; i<len; i++) begin
//           // @(posedge axi_vif.clk);
//           axi_vif.axi_wdata   <= mem.read(m_item.axi_awaddr + i);
//           axi_vif.axi_wstrb   <= m_item.axi_wstrb;
//           axi_vif.axi_wlast   <= (i == len - 1) ? 1:0;
//           axi_vif.axi_wvalid  <= m_item.axi_wvalid;
//           @(posedge axi_vif.clk);
//         end
//           axi_vif.axi_wvalid  <= 1'b0;
//           axi_vif.axi_wlast <= 0;
//     end
// endtask

virtual task drive_item (master_item m_item);
  wait(!axi_vif.rst) begin
    // if (!m_item.operation) begin
    fork
    r_addr(m_item);
    r_data(m_item);
    join
  // end else begin

  //   fork
  //   axi_vif.axi_bready <= 1'b1; 
  //   w_addr(m_item);
  //   w_data(m_item);
  //   join
  // end
  end
endtask

endclass