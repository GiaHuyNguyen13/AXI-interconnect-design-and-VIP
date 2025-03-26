class slave_monitor extends uvm_monitor;
   `uvm_component_utils (slave_monitor)
   function new (string name="slave_monitor", uvm_component parent);
      super.new (name, parent);
   endfunction

   uvm_analysis_port #(slave_item)  axi_mon_ap;
   virtual axi_interface          axi_vif;
   slave_item m_item_beat;

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

    m_item_beat = slave_item::type_id::create("m_item_beat");
    forever begin
      @(posedge axi_vif.clk) begin
        if (axi_vif.axi_wvalid && axi_vif.axi_wready) begin
          
          m_item_beat.axi_awid    = axi_vif.axi_awid;
          m_item_beat.axi_awaddr  = axi_vif.axi_awaddr;
          m_item_beat.axi_awlen   = axi_vif.axi_awlen;
          m_item_beat.axi_awsize  = axi_vif.axi_awsize;
          m_item_beat.axi_awburst = axi_vif.axi_awburst;
          m_item_beat.axi_awlock  = axi_vif.axi_awlock;
          m_item_beat.axi_awcache = axi_vif.axi_awcache;
          m_item_beat.axi_awprot  = axi_vif.axi_awprot;
          m_item_beat.axi_awvalid = axi_vif.axi_awvalid;
          m_item_beat.axi_awready = axi_vif.axi_awready;
          // Write data line
          m_item_beat.axi_wdata   = axi_vif.axi_wdata;
          m_item_beat.axi_wstrb   = axi_vif.axi_wstrb;
          m_item_beat.axi_wlast   = axi_vif.axi_wlast;
          m_item_beat.axi_wvalid  = axi_vif.axi_wvalid;
          m_item_beat.axi_wready  = axi_vif.axi_wready;

          m_item_beat.axi_bid     = axi_vif.axi_bid;
          m_item_beat.axi_bresp   = axi_vif.axi_bresp;
          m_item_beat.axi_bvalid  = axi_vif.axi_bvalid;
          m_item_beat.axi_bready  = axi_vif.axi_bready;
          axi_mon_ap.write(m_item_beat); 
        end

        if (axi_vif.axi_rvalid && axi_vif.axi_rready) begin
              // Read address line
              m_item_beat.axi_arid    = axi_vif.axi_arid;
              m_item_beat.axi_araddr  = axi_vif.axi_araddr;
              m_item_beat.axi_arlen   = axi_vif.axi_arlen;
              m_item_beat.axi_arsize  = axi_vif.axi_arsize;
              m_item_beat.axi_arburst = axi_vif.axi_arburst;
              m_item_beat.axi_arlock  = axi_vif.axi_arlock;
              m_item_beat.axi_arcache = axi_vif.axi_arcache;
              m_item_beat.axi_arprot  = axi_vif.axi_arprot;
              m_item_beat.axi_arvalid = axi_vif.axi_arvalid;
              m_item_beat.axi_arready = axi_vif.axi_arready; 
              // Read data line
              m_item_beat.axi_rid     = axi_vif.axi_rid;
              m_item_beat.axi_rdata   = axi_vif.axi_rdata;
              m_item_beat.axi_rresp   = axi_vif.axi_rresp;
              m_item_beat.axi_rlast   = axi_vif.axi_rlast;
              m_item_beat.axi_rvalid  = axi_vif.axi_rvalid;
              m_item_beat.axi_rready  = axi_vif.axi_rready;
              axi_mon_ap.write(m_item_beat);
        end
      end
    end
  endtask
endclass
