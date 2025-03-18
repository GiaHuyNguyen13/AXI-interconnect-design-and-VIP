class axi_interconnect_rd_ref_model;

  bit [31:0] S1_WIDTH;
  bit slave_num; // 0 for slave 1, 1 for slave 2

  // Class member to store the AXI sequence
  master_item master_sequence[$];  // Declare as a queue to use push_back
  slave_item  slave_sequence[$];  // Declare as a queue to use push_back

  // Handle for the centralized memory model
  centralized_memory_model slv1_memory;
  centralized_memory_model slv2_memory;

  // Constructor with centralized memory model instance
  function new();
    
  endfunction

  // Function to set the centralized memory model
  function void set_memory(centralized_memory_model slv1_memory, centralized_memory_model slv2_memory);
    this.slv1_memory = slv1_memory;  // Store the reference to the centralized memory
    this.slv2_memory = slv2_memory;  // Store the reference to the centralized memory
  endfunction

  function void create_expected_rd_sequence(master_item master_tr);
    master_sequence.delete();  // Clear the queue before starting
    slave_sequence.delete();  // Clear the queue before starting
    bit [31:0] init_addr;
    
    if (master_tr.axi_araddr >= S1_WIDTH) begin init_addr = master_tr.axi_araddr - S1_WIDTH; slave_num = 1; end
    else begin init_addr = master_tr.axi_araddr; slave_num = 0; end

    // Loop over each beat in the burst, generating an AXI transaction for each
    for (int i = 0; i <= master_tr.axi_arlen; i++) begin
      // master_item expected_master_tr = master_item::type_id::create("expected_master_tr_seq");
      slave_item  expected_slave_tr = slave_item::type_id::create("expected_slave_tr_seq");

      // Calculate the address for each beat in the burst
      int address = init_addr + (i * (1 << master_tr.axi_arsize));

      //Slave
         // Read address line
        expected_slave_tr.axi_arid      = master_tr.axi_arid;
        expected_slave_tr.axi_araddr    = master_tr.axi_araddr;
        expected_slave_tr.axi_arlen     = master_tr.axi_arlen;
        expected_slave_tr.axi_arsize    = master_tr.axi_arsize;
        expected_slave_tr.axi_arburst   = master_tr.axi_arburst;
        expected_slave_tr.axi_arlock    = master_tr.axi_arlock;
        expected_slave_tr.axi_arcache   = master_tr.axi_arcache;
        expected_slave_tr.axi_arprot    = master_tr.axi_arprot;
        expected_slave_tr.axi_arvalid   = master_tr.axi_arvalid;
        expected_slave_tr.axi_arready   = 1'b1; // Slave return

        // Read data line
        expected_slave_tr.axi_rid       = master_tr.axi_arid; // Slave return

        if (slave_num == 0) // Slave 1
        expected_slave_tr.axi_rdata     = slv1_memory.read(address); // Slave return
        else
        expected_slave_tr.axi_rdata     = slv2_memory.read(address); // Slave return

        expected_slave_tr.axi_rresp     = 2'b00; // Slave return
        expected_slave_tr.axi_rvalid    = 1'b1; // Slave return
        expected_slave_tr.axi_rready    = master_tr.axi_rready;

        if (i == master_tr.axi_arlen)
        expected_slave_tr.axi_rlast     = 1'b1; // Slave return
        else
        expected_slave_tr.axi_rlast     = 1'b0; // Slave return

          
      // master_sequence.push_back(expected_master_tr);
      slave_sequence.push_back(expected_slave_tr);
    end
  endfunction

endclass
