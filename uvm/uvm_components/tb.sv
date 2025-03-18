// `include "uvm_macros.svh"
`include "uvm.sv"
import uvm_pkg::*;

module tb;
  logic clk, rst;
  parameter S1_WIDTH = 32'h8000_0000;

// Clock gen
  initial begin
    clk = 0;
    forever #10 clk = ~clk; 
  end

// Reset gen
  initial begin
    rst = 1'b1;
    #100 rst = 1'b0;
  end

  // Reset gen
  // initial begin
  //   repeat (1000) @(posedge clk);
  //   $finish();
  // end

  initial begin
  $dumpfile("waveform.vcd");  // Specify the dump file name
  $dumpvars(0, tb); // Dump all signals in the design hierarchy under <top_module>
  end

// Interface connect
  axi_interface mas1_if (clk, rst);
  axi_interface mas2_if (clk, rst);
  axi_interface slv1_if (clk, rst);
  axi_interface slv2_if (clk, rst);


// Set interface to database and run test
  initial begin
    uvm_config_db#(virtual axi_interface)::set(null, "uvm_test_top.env.m1", "axi_if", mas1_if);
    uvm_config_db#(virtual axi_interface)::set(null, "uvm_test_top.env.m2", "axi_if", mas2_if);
    uvm_config_db#(virtual axi_interface)::set(null, "uvm_test_top.env.s1", "axi_if", slv1_if);
    uvm_config_db#(virtual axi_interface)::set(null, "uvm_test_top.env.s2", "axi_if", slv2_if);
    uvm_config_db#(bit [31:0])::set(null, "*", "S1_WIDTH", S1_WIDTH);
    run_test("base_test");
  end

  // Instantiate DUT
  axi_interconnect #(
    .S1_WIDTH(S1_WIDTH)   
) dut(

    .i_clk(clk),
    .i_rstn(rst),

    // Master 1 Interface
    .m1_awaddr (mas1_if.axi_awaddr),
    .m1_awid (mas1_if.axi_awid),
    .m1_awlen (mas1_if.axi_awlen),
    .m1_awsize (mas1_if.axi_awsize),
    .m1_awburst (mas1_if.axi_awburst),
    .m1_awlock (mas1_if.axi_awlock),
    .m1_awcache (mas1_if.axi_awcache),
    .m1_awprot (mas1_if.axi_awprot),
    .m1_awvalid (mas1_if.axi_awvalid),
    .m1_awready (mas1_if.axi_awready),
    .m1_wdata (mas1_if.axi_wdata),
    .m1_wstrb (mas1_if.axi_wstrb),
    .m1_wlast (mas1_if.axi_wlast),
    .m1_wvalid (mas1_if.axi_wvalid),
    .m1_wready (mas1_if.axi_wready),
    .m1_bid (mas1_if.axi_bid),
    .m1_bresp (mas1_if.axi_bresp),
    .m1_bvalid (mas1_if.axi_bvalid),
    .m1_bready (mas1_if.axi_bready),
    .m1_araddr (mas1_if.axi_araddr),
    .m1_arid (mas1_if.axi_arid),
    .m1_arlen (mas1_if.axi_arlen),
    .m1_arsize (mas1_if.axi_arsize),
    .m1_arburst (mas1_if.axi_arburst),
    .m1_arlock (mas1_if.axi_arlock),
    .m1_arcache (mas1_if.axi_arcache),
    .m1_arprot (mas1_if.axi_arprot),
    .m1_arvalid (mas1_if.axi_arvalid),
    .m1_arready (mas1_if.axi_arready),
    .m1_rid (mas1_if.axi_rid),
    .m1_rdata (mas1_if.axi_rdata),
    .m1_rresp (mas1_if.axi_rresp),
    .m1_rlast (mas1_if.axi_rlast),
    .m1_rvalid (mas1_if.axi_rvalid),
    .m1_rready (mas1_if.axi_rready),

    // Master 2 Interface
    .m2_awaddr (mas2_if.axi_awaddr),
    .m2_awid (mas2_if.axi_awid),
    .m2_awlen (mas2_if.axi_awlen),
    .m2_awsize (mas2_if.axi_awsize),
    .m2_awburst (mas2_if.axi_awburst),
    .m2_awlock (mas2_if.axi_awlock),
    .m2_awcache (mas2_if.axi_awcache),
    .m2_awprot (mas2_if.axi_awprot),
    .m2_awvalid (mas2_if.axi_awvalid),
    .m2_awready (mas2_if.axi_awready),
    .m2_wdata (mas2_if.axi_wdata),
    .m2_wstrb (mas2_if.axi_wstrb),
    .m2_wlast (mas2_if.axi_wlast),
    .m2_wvalid (mas2_if.axi_wvalid),
    .m2_wready (mas2_if.axi_wready),
    .m2_bid (mas2_if.axi_bid),
    .m2_bresp (mas2_if.axi_bresp),
    .m2_bvalid (mas2_if.axi_bvalid),
    .m2_bready (mas2_if.axi_bready),
    .m2_araddr (mas2_if.axi_araddr),
    .m2_arid (mas2_if.axi_arid),
    .m2_arlen (mas2_if.axi_arlen),
    .m2_arsize (mas2_if.axi_arsize),
    .m2_arburst (mas2_if.axi_arburst),
    .m2_arlock (mas2_if.axi_arlock),
    .m2_arcache (mas2_if.axi_arcache),
    .m2_arprot (mas2_if.axi_arprot),
    .m2_arvalid (mas2_if.axi_arvalid),
    .m2_arready (mas2_if.axi_arready),
    .m2_rid (mas2_if.axi_rid),
    .m2_rdata (mas2_if.axi_rdata),
    .m2_rresp (mas2_if.axi_rresp),
    .m2_rlast (mas2_if.axi_rlast),
    .m2_rvalid (mas2_if.axi_rvalid),
    .m2_rready (mas2_if.axi_rready),

    // Slave 1 Interface
    .s1_awaddr (slv1_if.axi_awaddr),
    .s1_awid (slv1_if.axi_awid),
    .s1_awlen (slv1_if.axi_awlen),
    .s1_awsize (slv1_if.axi_awsize),
    .s1_awburst (slv1_if.axi_awburst),
    .s1_awlock (slv1_if.axi_awlock),
    .s1_awcache (slv1_if.axi_awcache),
    .s1_awprot (slv1_if.axi_awprot),
    .s1_awvalid (slv1_if.axi_awvalid),
    .s1_awready (slv1_if.axi_awready),
    .s1_wdata (slv1_if.axi_wdata),
    .s1_wstrb (slv1_if.axi_wstrb),
    .s1_wlast (slv1_if.axi_wlast),
    .s1_wvalid (slv1_if.axi_wvalid),
    .s1_wready (slv1_if.axi_wready),
    .s1_bid (slv1_if.axi_bid),
    .s1_bresp (slv1_if.axi_bresp),
    .s1_bvalid (slv1_if.axi_bvalid),
    .s1_bready (slv1_if.axi_bready),
    .s1_araddr (slv1_if.axi_araddr),
    .s1_arid (slv1_if.axi_arid),
    .s1_arlen (slv1_if.axi_arlen),
    .s1_arsize (slv1_if.axi_arsize),
    .s1_arburst (slv1_if.axi_arburst),
    .s1_arlock (slv1_if.axi_arlock),
    .s1_arcache (slv1_if.axi_arcache),
    .s1_arprot (slv1_if.axi_arprot),
    .s1_arvalid (slv1_if.axi_arvalid),
    .s1_arready (slv1_if.axi_arready),
    .s1_rid (slv1_if.axi_rid),
    .s1_rdata (slv1_if.axi_rdata),
    .s1_rresp (slv1_if.axi_rresp),
    .s1_rlast (slv1_if.axi_rlast),
    .s1_rvalid (slv1_if.axi_rvalid),
    .s1_rready (slv1_if.axi_rready),

    // Slave 2 Interface
    .s2_awaddr (slv2_if.axi_awaddr),
    .s2_awid (slv2_if.axi_awid),
    .s2_awlen (slv2_if.axi_awlen),
    .s2_awsize (slv2_if.axi_awsize),
    .s2_awburst (slv2_if.axi_awburst),
    .s2_awlock (slv2_if.axi_awlock),
    .s2_awcache (slv2_if.axi_awcache),
    .s2_awprot (slv2_if.axi_awprot),
    .s2_awvalid (slv2_if.axi_awvalid),
    .s2_awready (slv2_if.axi_awready),
    .s2_wdata (slv2_if.axi_wdata),
    .s2_wstrb (slv2_if.axi_wstrb),
    .s2_wlast (slv2_if.axi_wlast),
    .s2_wvalid (slv2_if.axi_wvalid),
    .s2_wready (slv2_if.axi_wready),
    .s2_bid (slv2_if.axi_bid),
    .s2_bresp (slv2_if.axi_bresp),
    .s2_bvalid (slv2_if.axi_bvalid),
    .s2_bready (slv2_if.axi_bready),
    .s2_araddr (slv2_if.axi_araddr),
    .s2_arid (slv2_if.axi_arid),
    .s2_arlen (slv2_if.axi_arlen),
    .s2_arsize (slv2_if.axi_arsize),
    .s2_arburst (slv2_if.axi_arburst),
    .s2_arlock (slv2_if.axi_arlock),
    .s2_arcache (slv2_if.axi_arcache),
    .s2_arprot (slv2_if.axi_arprot),
    .s2_arvalid (slv2_if.axi_arvalid),
    .s2_arready (slv2_if.axi_arready),
    .s2_rid (slv2_if.axi_rid),
    .s2_rdata (slv2_if.axi_rdata),
    .s2_rresp (slv2_if.axi_rresp),
    .s2_rlast (slv2_if.axi_rlast),
    .s2_rvalid (slv2_if.axi_rvalid),
    .s2_rready (slv2_if.axi_rready)
  );

  


endmodule
