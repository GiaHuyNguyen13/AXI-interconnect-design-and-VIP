class master_monitor extends uvm_monitor;
   `uvm_component_utils (master_monitor)
   function new (string name="master_monitor", uvm_component parent);
      super.new (name, parent);
   endfunction

   uvm_analysis_port #(master_item)  axi_mon_ap;
   virtual axi_interface          axi_vif;
   master_item wr_item_beat, rd_item_beat;

  virtual function void build_phase (uvm_phase phase);
  super.build_phase(phase);
  if (!uvm_config_db #(virtual axi_interface)::get(this, "", "interface", axi_vif))
      `uvm_fatal("MON", "Could not get axi_vif")
    axi_mon_ap = new ("axi_mon_ap", this); // create analysis port
  endfunction

  virtual task run_phase (uvm_phase phase);
    super.run_phase(phase);
    // This task monitors the interface for a complete 
    // transaction and writes into analysis port when complete

    
    forever begin
      // m_item_beat = master_item::type_id::create("m_item_beat");
      wr_item_beat = master_item::type_id::create("wr_item_beat");
      rd_item_beat = master_item::type_id::create("rd_item_beat");
      //`uvm_info("MON_Master", $sformatf("I'm at Monitor"), UVM_LOW);
      @(posedge axi_vif.clk) begin

        if (axi_vif.axi_rvalid && axi_vif.axi_rready) begin
              // Read address line
              rd_item_beat.axi_arid    = axi_vif.axi_arid;
              rd_item_beat.axi_araddr  = axi_vif.axi_araddr;
              rd_item_beat.axi_arlen   = axi_vif.axi_arlen;
              rd_item_beat.axi_arsize  = axi_vif.axi_arsize;
              rd_item_beat.axi_arburst = axi_vif.axi_arburst;
              rd_item_beat.axi_arlock  = axi_vif.axi_arlock;
              rd_item_beat.axi_arcache = axi_vif.axi_arcache;
              rd_item_beat.axi_arprot  = axi_vif.axi_arprot;
              rd_item_beat.axi_arvalid = axi_vif.axi_arvalid;
              rd_item_beat.axi_arready = axi_vif.axi_arready; 
              // Read data line
              rd_item_beat.axi_rid     = axi_vif.axi_rid;
              rd_item_beat.axi_rdata   = axi_vif.axi_rdata;
              rd_item_beat.axi_rresp   = axi_vif.axi_rresp;
              rd_item_beat.axi_rlast   = axi_vif.axi_rlast;
              rd_item_beat.axi_rvalid  = axi_vif.axi_rvalid;
              rd_item_beat.axi_rready  = axi_vif.axi_rready;
              axi_mon_ap.write(rd_item_beat);
        end
        if (axi_vif.axi_wvalid && axi_vif.axi_wready) begin
          wr_item_beat.axi_awid    = axi_vif.axi_awid;
          wr_item_beat.axi_awaddr  = axi_vif.axi_awaddr;
          wr_item_beat.axi_awlen   = axi_vif.axi_awlen;
          wr_item_beat.axi_awsize  = axi_vif.axi_awsize;
          wr_item_beat.axi_awburst = axi_vif.axi_awburst;
          wr_item_beat.axi_awlock  = axi_vif.axi_awlock;
          wr_item_beat.axi_awcache = axi_vif.axi_awcache;
          wr_item_beat.axi_awprot  = axi_vif.axi_awprot;
          wr_item_beat.axi_awvalid = axi_vif.axi_awvalid;
          wr_item_beat.axi_awready = axi_vif.axi_awready;
          // Write data line
          wr_item_beat.axi_wdata   = axi_vif.axi_wdata;
          wr_item_beat.axi_wstrb   = axi_vif.axi_wstrb;
          wr_item_beat.axi_wlast   = axi_vif.axi_wlast;
          wr_item_beat.axi_wvalid  = axi_vif.axi_wvalid;
          wr_item_beat.axi_wready  = axi_vif.axi_wready;

          wr_item_beat.axi_bid     = axi_vif.axi_bid;
          wr_item_beat.axi_bresp   = axi_vif.axi_bresp;
          wr_item_beat.axi_bvalid  = axi_vif.axi_bvalid;
          wr_item_beat.axi_bready  = axi_vif.axi_bready;
          axi_mon_ap.write(wr_item_beat); 
        end
      end
    end
  endtask
endclass
