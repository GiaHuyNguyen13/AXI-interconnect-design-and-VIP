class slave_monitor extends uvm_monitor;
   `uvm_component_utils (slave_monitor)
   function new (string name="slave_monitor", uvm_component parent);
      super.new (name, parent);
   endfunction

   uvm_analysis_port #(slave_item)  axi_mon_ap;
   virtual axi_interface          axi_vif;

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
        // @(axi_vif.clk);
        slave_item m_item_beat;
        slave_item m_item = slave_item::type_id::create("m_item");
        @(posedge axi_vif.clk) begin
        // wait ((axi_vif.axi_awvalid && axi_vif.axi_awready) || (axi_vif.axi_arvalid && axi_vif.axi_arready));
        // `uvm_info("MNT", $sformatf("Read data is correct"), UVM_HIGH)
        if (axi_vif.axi_awvalid && axi_vif.axi_awready) begin
            // Write address line
            m_item.axi_awid    = axi_vif.axi_awid;
            m_item.axi_awaddr  = axi_vif.axi_awaddr;
            m_item.axi_awlen   = axi_vif.axi_awlen;
            m_item.axi_awsize  = axi_vif.axi_awsize;
            m_item.axi_awburst = axi_vif.axi_awburst;
            m_item.axi_awlock  = axi_vif.axi_awlock;
            m_item.axi_awcache = axi_vif.axi_awcache;
            m_item.axi_awprot  = axi_vif.axi_awprot;
            m_item.axi_awvalid = axi_vif.axi_awvalid;
            m_item.axi_awready = axi_vif.axi_awready;
            //axi_mon_ap.write(m_item);

            for (int i = 0; i <= axi_vif.axi_awlen; i++) begin
              wait (axi_vif.axi_wvalid && axi_vif.axi_wready);
              m_item_beat = slave_item::type_id::create("m_item_beat");
              m_item_beat.axi_awid    = m_item.axi_awid;
              m_item_beat.axi_awaddr  = m_item.axi_awaddr;
              m_item_beat.axi_awlen   = m_item.axi_awlen;
              m_item_beat.axi_awsize  = m_item.axi_awsize;
              m_item_beat.axi_awburst = m_item.axi_awburst;
              m_item_beat.axi_awlock  = m_item.axi_awlock;
              m_item_beat.axi_awcache = m_item.axi_awcache;
              m_item_beat.axi_awprot  = m_item.axi_awprot;
              m_item_beat.axi_awvalid = m_item.axi_awvalid;
              m_item_beat.axi_awready = m_item.axi_awready;
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
              
              // if (i == axi_vif.axi_awlen) begin
              
              // wait (axi_vif.axi_bvalid && axi_vif.axi_bready);
              // //`uvm_info("AXI_MON", $sformatf("AXI I'm in"), UVM_HIGH)
              //     // Write response line
              //     m_item.axi_bid     = axi_vif.axi_bid;
              //     m_item.axi_bresp   = axi_vif.axi_bresp;
              //     m_item.axi_bvalid  = axi_vif.axi_bvalid;
              //     m_item.axi_bready  = axi_vif.axi_bready;     
              //     `uvm_info("AXI_MON", $sformatf("m_item_beat.axi_bready: %0d",axi_vif.axi_bready), UVM_HIGH)
              //     axi_mon_ap.write(m_item);
              // end
              if (axi_vif.axi_wlast) begin
                break;  // Exit the loop after the last data beat
              end
            end
        end

        if (axi_vif.axi_arvalid && axi_vif.axi_arready) begin
            // Read address line
            m_item.axi_arid    = axi_vif.axi_arid;
            m_item.axi_araddr  = axi_vif.axi_araddr;
            m_item.axi_arlen   = axi_vif.axi_arlen;
            m_item.axi_arsize  = axi_vif.axi_arsize;
            m_item.axi_arburst = axi_vif.axi_arburst;
            m_item.axi_arlock  = axi_vif.axi_arlock;
            m_item.axi_arcache = axi_vif.axi_arcache;
            m_item.axi_arprot  = axi_vif.axi_arprot;
            m_item.axi_arvalid = axi_vif.axi_arvalid;
            m_item.axi_arready = axi_vif.axi_arready;
            // axi_mon_ap.write(m_item);   

            for (int i = 0; i <= axi_vif.axi_arlen; i++) begin
              wait (axi_vif.axi_rvalid && axi_vif.axi_rready);
              m_item_beat = slave_item::type_id::create("m_item_beat");
              // Read address line
              m_item_beat.axi_arid    = m_item.axi_arid;
              m_item_beat.axi_araddr  = m_item.axi_araddr;
              m_item_beat.axi_arlen   = m_item.axi_arlen;
              m_item_beat.axi_arsize  = m_item.axi_arsize;
              m_item_beat.axi_arburst = m_item.axi_arburst;
              m_item_beat.axi_arlock  = m_item.axi_arlock;
              m_item_beat.axi_arcache = m_item.axi_arcache;
              m_item_beat.axi_arprot  = m_item.axi_arprot;
              m_item_beat.axi_arvalid = m_item.axi_arvalid;
              m_item_beat.axi_arready = m_item.axi_arready; 
              // Read data line
              m_item_beat.axi_rid     = axi_vif.axi_rid;
              m_item_beat.axi_rdata   = axi_vif.axi_rdata;
              m_item_beat.axi_rresp   = axi_vif.axi_rresp;
              m_item_beat.axi_rlast   = axi_vif.axi_rlast;
              m_item_beat.axi_rvalid  = axi_vif.axi_rvalid;
              m_item_beat.axi_rready  = axi_vif.axi_rready;
              axi_mon_ap.write(m_item_beat);
              @(posedge axi_vif.clk)
              @(posedge axi_vif.clk)
              if (axi_vif.axi_rlast) begin
                break;  // Exit the loop after the last data beat
              end
            end
        end
    end
  end
  endtask
endclass
