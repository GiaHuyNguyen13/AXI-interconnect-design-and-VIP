interface axi_interface #
(
    parameter ADDR_WIDTH = 32,
    parameter AXI_DATA_WIDTH = 32,
    parameter AXI_STRB_WIDTH = (AXI_DATA_WIDTH/8),
    parameter AXI_ID_WIDTH = 8,
    parameter AXIL_DATA_WIDTH = 32,
    parameter AXIL_STRB_WIDTH = (AXIL_DATA_WIDTH/8),
    parameter CONVERT_BURST = 1,
    parameter CONVERT_NARROW_BURST = 0
)
(
    input  logic clk,
    input  logic rst
);

    // AXI slave interface
    logic [AXI_ID_WIDTH-1:0]    axi_awid;
    logic [ADDR_WIDTH-1:0]      axi_awaddr;
    logic [7:0]                 axi_awlen;
    logic [2:0]                 axi_awsize;
    logic [1:0]                 axi_awburst;
    logic                       axi_awlock;
    logic [3:0]                 axi_awcache;
    logic [2:0]                 axi_awprot;
    logic                       axi_awvalid;
    logic                       axi_awready;
    logic [AXI_DATA_WIDTH-1:0]  axi_wdata;
    logic [AXI_STRB_WIDTH-1:0]  axi_wstrb;
    logic                       axi_wlast;
    logic                       axi_wvalid;
    logic                       axi_wready;
    logic [AXI_ID_WIDTH-1:0]    axi_bid;
    logic [1:0]                 axi_bresp;
    logic                       axi_bvalid;
    logic                       axi_bready;
    logic [AXI_ID_WIDTH-1:0]    axi_arid;
    logic [ADDR_WIDTH-1:0]      axi_araddr;
    logic [7:0]                 axi_arlen;
    logic [2:0]                 axi_arsize;
    logic [1:0]                 axi_arburst;
    logic                       axi_arlock;
    logic [3:0]                 axi_arcache;
    logic [2:0]                 axi_arprot;
    logic                       axi_arvalid;
    logic                       axi_arready;
    logic [AXI_ID_WIDTH-1:0]    axi_rid;
    logic [AXI_DATA_WIDTH-1:0]  axi_rdata;
    logic [1:0]                 axi_rresp;
    logic                       axi_rlast;
    logic                       axi_rvalid;
    logic                       axi_rready;

endinterface