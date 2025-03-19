class slave_item extends uvm_sequence_item;
    `uvm_object_utils(slave_item)

   // /*rand*/ bit    operation; // 0 for read, 1 for write

   // Write address line
   /*rand*/ bit [7:0]   axi_awid;
   /*rand*/ bit [31:0]  axi_awaddr;
   /*rand*/ bit [7:0]   axi_awlen;
   /*rand*/ bit [2:0]   axi_awsize;
   /*rand*/ bit [1:0]   axi_awburst;
   /*rand*/ bit         axi_awlock;
   /*rand*/ bit [3:0]   axi_awcache;
   /*rand*/ bit [2:0]   axi_awprot;
   /*rand*/ bit         axi_awvalid;
        bit         axi_awready;

   // Write data line
   /*rand*/ bit [31:0]  axi_wdata;
   /*rand*/ bit [3:0]   axi_wstrb;
   /*rand*/ bit         axi_wlast;
   /*rand*/ bit         axi_wvalid;
        bit         axi_wready;

   // Write response line
        bit [7:0]   axi_bid;
        bit [1:0]   axi_bresp;
        bit         axi_bvalid;
   /*rand*/ bit         axi_bready;

   // Read address line
   /*rand*/ bit [7:0]   axi_arid;
   /*rand*/ bit [31:0]  axi_araddr;
   /*rand*/ bit [7:0]   axi_arlen;
   /*rand*/ bit [2:0]   axi_arsize;
   /*rand*/ bit [1:0]   axi_arburst;
   /*rand*/ bit         axi_arlock;
   /*rand*/ bit [3:0]   axi_arcache;
   /*rand*/ bit [2:0]   axi_arprot;
   /*rand*/ bit         axi_arvalid;
        bit         axi_arready;
   
   // Read data line
        bit [7:0]   axi_rid;
        bit [31:0]  axi_rdata;
        bit [1:0]   axi_rresp;
        bit         axi_rlast;
        bit         axi_rvalid;
   /*rand*/ bit         axi_rready;


   function new (string name="slave_item");
      super.new (name);
   endfunction

   // // *********** CONSTRAINTS *********** //
   // constraint c_op {
   //    soft operation == 1;
   //  }
   // constraint c_axi_awid {
   //    axi_awid inside {[0:255]};
   // }

   // constraint c_axi_awaddr {
   //    axi_awaddr inside {[0:15]};
   // }

   // constraint c_axi_awlen {
   //    soft axi_awlen inside {[3:3]};
   // }

   // constraint c_axi_awsize {
   //    axi_awsize inside {[0:0]};
   // }

   // constraint c_axi_awburst {
   //    axi_awburst inside {[0:0]};
   // }

   // constraint c_axi_awlock {
   //    axi_awlock inside {[0:0]};
   // }

   // constraint c_axi_awvalid {
   //    axi_awvalid inside {[1:1]};
   // }

   // constraint c_axi_wdata {
   //    axi_wdata inside {[0:2**32-1]};
   // }

   // constraint c_axi_wstrb {
   //    axi_wstrb inside {[0:15]};
   // }

   // constraint c_axi_wlast {
   //    axi_wlast inside {[1:1]};
   // }

   // constraint c_axi_wvalid {
   //    axi_wvalid inside {[1:1]};
   // }

   // constraint c_axi_bready {
   //    axi_bready inside {[1:1]};
   // }

   // constraint c_axi_arid {
   //    // axi_arid inside {[0:255]};
   //    axi_arid == 1;
   // }

   // constraint c_axi_araddr {
   //    axi_araddr inside {[1:10]};
   //    // axi_araddr == 1;
   // }

   // constraint c_axi_arlen {
   //    // axi_arlen inside {[0:255]};
   //    soft axi_arlen == 1;
   // }

   // constraint c_axi_arsize {
   //    // axi_arsize inside {[0:7]};
   //    axi_arsize == 0;
   // }

   // constraint c_axi_arburst {
   //    // axi_arburst inside {[0:3]};
   //    axi_arburst == 0;
   // }

   // constraint c_axi_arlock {
   //    axi_arlock inside {[0:0]};
   // }

   // constraint c_axi_arvalid {
   //    // axi_arvalid inside {[0:1]};
   //    axi_arvalid == 1'b1;
   // }

   // constraint c_axi_rready {
   //    axi_rready inside {[1:1]};
   // }

   // constraint prot_cache_zero {
   //    //axi_arprot == 3'b000;
   //    //axi_awprot == 3'b000;
   //    axi_arcache == 4'b0000;
   //    axi_awcache == 4'b0000;
   // }

function void print();
      string print_str;
      print_str = $sformatf("AXI Transaction:\n");
      // print_str = {print_str, $sformatf("  Operation: %0d\n", operation)};
      
      // Write address line
      print_str = {print_str, $sformatf("  axi_awid: 0x%0h\n", axi_awid)};
      print_str = {print_str, $sformatf("  axi_awaddr: 0x%0h\n", axi_awaddr)};
      print_str = {print_str, $sformatf("  axi_awlen: %0d\n", axi_awlen)};
      print_str = {print_str, $sformatf("  axi_awsize: %0d\n", axi_awsize)};
      print_str = {print_str, $sformatf("  axi_awburst: %0d\n", axi_awburst)};
      print_str = {print_str, $sformatf("  axi_awlock: %0d\n", axi_awlock)};
      print_str = {print_str, $sformatf("  axi_awcache: 0x%0h\n", axi_awcache)};
      print_str = {print_str, $sformatf("  axi_awprot: %0d\n", axi_awprot)};
      print_str = {print_str, $sformatf("  axi_awvalid: %0d\n", axi_awvalid)};
      print_str = {print_str, $sformatf("  axi_awready: %0d\n", axi_awready)};
      
      // Write data line
      print_str = {print_str, $sformatf("  axi_wdata: 0x%0h\n", axi_wdata)};
      print_str = {print_str, $sformatf("  axi_wstrb: 0x%0h\n", axi_wstrb)};
      print_str = {print_str, $sformatf("  axi_wlast: %0d\n", axi_wlast)};
      print_str = {print_str, $sformatf("  axi_wvalid: %0d\n", axi_wvalid)};
      print_str = {print_str, $sformatf("  axi_wready: %0d\n", axi_wready)};
      
      // Write response line
      print_str = {print_str, $sformatf("  axi_bid: 0x%0h\n", axi_bid)};
      print_str = {print_str, $sformatf("  axi_bresp: %0d\n", axi_bresp)};
      print_str = {print_str, $sformatf("  axi_bvalid: %0d\n", axi_bvalid)};
      print_str = {print_str, $sformatf("  axi_bready: %0d\n", axi_bready)};
      
      // Read address line
      print_str = {print_str, $sformatf("  axi_arid: 0x%0h\n", axi_arid)};
      print_str = {print_str, $sformatf("  axi_araddr: 0x%0h\n", axi_araddr)};
      print_str = {print_str, $sformatf("  axi_arlen: %0d\n", axi_arlen)};
      print_str = {print_str, $sformatf("  axi_arsize: %0d\n", axi_arsize)};
      print_str = {print_str, $sformatf("  axi_arburst: %0d\n", axi_arburst)};
      print_str = {print_str, $sformatf("  axi_arlock: %0d\n", axi_arlock)};
      print_str = {print_str, $sformatf("  axi_arcache: 0x%0h\n", axi_arcache)};
      print_str = {print_str, $sformatf("  axi_arprot: %0d\n", axi_arprot)};
      print_str = {print_str, $sformatf("  axi_arvalid: %0d\n", axi_arvalid)};
      print_str = {print_str, $sformatf("  axi_arready: %0d\n", axi_arready)};
      
      // Read data line
      print_str = {print_str, $sformatf("  axi_rid: 0x%0h\n", axi_rid)};
      print_str = {print_str, $sformatf("  axi_rdata: 0x%0h\n", axi_rdata)};
      print_str = {print_str, $sformatf("  axi_rresp: %0d\n", axi_rresp)};
      print_str = {print_str, $sformatf("  axi_rlast: %0d\n", axi_rlast)};
      print_str = {print_str, $sformatf("  axi_rvalid: %0d\n", axi_rvalid)};
      print_str = {print_str, $sformatf("  axi_rready: %0d\n", axi_rready)};
      
      // Print the formatted string to the console
      $display("%s", print_str);
   endfunction
endclass                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                