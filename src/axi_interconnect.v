module axi_interconnect (
    input wire         i_clk, i_rstn,

    // Master 1 Interface
    // Write Address (AW)
    input wire  [31:0] m1_awaddr,
    input wire  [7:0]  m1_awid,
    input wire  [7:0]  m1_awlen,
    input wire  [2:0]  m1_awsize,
    input wire  [1:0]  m1_awburst,
    input wire         m1_awlock,
    input wire  [3:0]  m1_awcache,
    input wire  [2:0]  m1_awprot,
    input wire         m1_awvalid,
    output wire         m1_awready,
    // Write Data (W)
    input wire  [31:0] m1_wdata,
    input wire  [3:0]  m1_wstrb,
    input wire         m1_wlast,
    input wire         m1_wvalid,
    output wire         m1_wready,
    // Write Response (B)
    input wire  [7:0]  m1_bid,
    output wire  [1:0]  m1_bresp,
    output wire         m1_bvalid,
    input wire         m1_bready,
    // Read Address (AR)
    input wire  [31:0] m1_araddr,
    input wire  [7:0]  m1_arid,
    input wire  [7:0]  m1_arlen,
    input wire  [2:0]  m1_arsize,
    input wire  [1:0]  m1_arburst,
    input wire         m1_arlock,
    input wire  [3:0]  m1_arcache,
    input wire  [2:0]  m1_arprot,
    input wire         m1_arvalid,
    output wire         m1_arready,
    // Read Data (R)
    output wire  [7:0]  m1_rid,
    output wire  [31:0] m1_rdata,
    output wire  [1:0]  m1_rresp,
    output wire         m1_rlast,
    output wire         m1_rvalid,
    input wire         m1_rready,

    // Master 2 Interface
    // Write Address (AW)
    input wire  [31:0] m2_awaddr,
    input wire  [7:0]  m2_awid,
    input wire  [7:0]  m2_awlen,
    input wire  [2:0]  m2_awsize,
    input wire  [1:0]  m2_awburst,
    input wire         m2_awlock,
    input wire  [3:0]  m2_awcache,
    input wire  [2:0]  m2_awprot,
    input wire         m2_awvalid,
    output wire         m2_awready,
    // Write Data (W)
    input wire  [31:0] m2_wdata,
    input wire  [3:0]  m2_wstrb,
    input wire         m2_wlast,
    input wire         m2_wvalid,
    output wire         m2_wready,
    // Write Response (B)
    input wire  [7:0]  m2_bid,
    output wire  [1:0]  m2_bresp,
    output wire         m2_bvalid,
    input wire         m2_bready,
    // Read Address (AR)
    input wire  [31:0] m2_araddr,
    input wire  [7:0]  m2_arid,
    input wire  [7:0]  m2_arlen,
    input wire  [2:0]  m2_arsize,
    input wire  [1:0]  m2_arburst,
    input wire         m2_arlock,
    input wire  [3:0]  m2_arcache,
    input wire  [2:0]  m2_arprot,
    input wire         m2_arvalid,
    output wire         m2_arready,
    // Read Data (R)
    output wire  [7:0]  m2_rid,
    output wire  [31:0] m2_rdata,
    output wire  [1:0]  m2_rresp,
    output wire         m2_rlast,
    output wire         m2_rvalid,
    input wire         m2_rready,

    // Slave 1 Interface
    // Write Address (AW)
    output reg  [31:0] s1_awaddr,
    output reg  [7:0]  s1_awid,
    output reg  [7:0]  s1_awlen,
    output reg  [2:0]  s1_awsize,
    output reg  [1:0]  s1_awburst,
    output reg         s1_awlock,
    output reg  [3:0]  s1_awcache,
    output reg  [2:0]  s1_awprot,
    output reg         s1_awvalid,
    input wire         s1_awready,
    // Write Data (W)
    output reg  [31:0] s1_wdata,
    output reg  [3:0]  s1_wstrb,
    output reg         s1_wlast,
    output reg         s1_wvalid,
    input wire         s1_wready,
    // Write Response (B)
    output reg  [7:0]  s1_bid,
    input wire  [1:0]  s1_bresp,
    input wire         s1_bvalid,
    output reg         s1_bready,
    // Read Address (AR)
    output reg  [31:0] s1_araddr,
    output reg  [7:0]  s1_arid,
    output reg  [7:0]  s1_arlen,
    output reg  [2:0]  s1_arsize,
    output reg  [1:0]  s1_arburst,
    output reg         s1_arlock,
    output reg  [3:0]  s1_arcache,
    output reg  [2:0]  s1_arprot,
    output reg         s1_arvalid,
    input wire         s1_arready,
    // Read Data (R)
    input wire  [7:0]  s1_rid,
    input wire  [31:0] s1_rdata,
    input wire  [1:0]  s1_rresp,
    input wire         s1_rlast,
    input wire         s1_rvalid,
    output reg         s1_rready,

    // Slave 2 Interface
    // Write Address (AW)
    output reg  [31:0] s2_awaddr,
    output reg  [7:0]  s2_awid,
    output reg  [7:0]  s2_awlen,
    output reg  [2:0]  s2_awsize,
    output reg  [1:0]  s2_awburst,
    output reg         s2_awlock,
    output reg  [3:0]  s2_awcache,
    output reg  [2:0]  s2_awprot,
    output reg         s2_awvalid,
    input wire         s2_awready,
    // Write Data (W)
    output reg  [31:0] s2_wdata,
    output reg  [3:0]  s2_wstrb,
    output reg         s2_wlast,
    output reg         s2_wvalid,
    input wire         s2_wready,
    // Write Response (B)
    output reg  [7:0]  s2_bid,
    input wire  [1:0]  s2_bresp,
    input wire         s2_bvalid,
    output reg         s2_bready,
    // Read Address (AR)
    output reg  [31:0] s2_araddr,
    output reg  [7:0]  s2_arid,
    output reg  [7:0]  s2_arlen,
    output reg  [2:0]  s2_arsize,
    output reg  [1:0]  s2_arburst,
    output reg         s2_arlock,
    output reg  [3:0]  s2_arcache,
    output reg  [2:0]  s2_arprot,
    output reg         s2_arvalid,
    input wire         s2_arready,
    // Read Data (R)
    input wire  [7:0]  s2_rid,
    input wire  [31:0] s2_rdata,
    input wire  [1:0]  s2_rresp,
    input wire         s2_rlast,
    input wire         s2_rvalid,
    output reg         s2_rready  
);
//parameter S1_WIDTH = 32'h8000_0000;
parameter S1_WIDTH = 32'h0000_0200;  //512
// Master 1 decoder
// Slave selection signals
wire m1s1_wr_sel, m1s1_rd_sel, m1s2_wr_sel, m1s2_rd_sel;
// Slave decoded address signals
wire [31:0] m1s1_wr_addr, m1s1_rd_addr, m1s2_wr_addr, m1s2_rd_addr;

// Master 2 decoder
// Slave selection signals
wire m2s1_rd_sel, m2s1_wr_sel, m2s2_wr_sel, m2s2_rd_sel;
// Slave decoded address signals
wire [31:0] m2s1_wr_addr, m2s1_rd_addr, m2s2_wr_addr, m2s2_rd_addr;

// Master select
wire [1:0] mas_sel_s1_rd, mas_sel_s1_wr, mas_sel_s2_wr, mas_sel_s2_rd;

addr_decoder #(.S1_WIDTH(S1_WIDTH))
decoder_m1(
    .rd_addr       (m1_araddr), 
    .wr_addr       (m1_awaddr),
    .rd_slave1_sel (m1s1_rd_sel), 
    .rd_slave2_sel (m1s2_rd_sel), 
    .wr_slave1_sel (m1s1_wr_sel), 
    .wr_slave2_sel (m1s2_wr_sel), 
    .s1_wr_addr    (m1s1_wr_addr), 
    .s2_wr_addr    (m1s2_wr_addr), 
    .s1_rd_addr    (m1s1_rd_addr), 
    .s2_rd_addr    (m1s2_rd_addr),
    .rd_addr_valid (m1_arvalid),
    .wr_addr_valid (m1_awvalid)
);

addr_decoder #(.S1_WIDTH(S1_WIDTH))
decoder_m2(
    .rd_addr       (m2_araddr), 
    .wr_addr       (m2_awaddr),
    .rd_slave1_sel (m2s1_rd_sel), 
    .rd_slave2_sel (m2s2_rd_sel), 
    .wr_slave1_sel (m2s1_wr_sel), 
    .wr_slave2_sel (m2s2_wr_sel), 
    .s1_wr_addr    (m2s1_wr_addr), 
    .s2_wr_addr    (m2s2_wr_addr), 
    .s1_rd_addr    (m2s1_rd_addr), 
    .s2_rd_addr    (m2s2_rd_addr),
    .rd_addr_valid (m2_arvalid),
    .wr_addr_valid (m2_awvalid)
);

wr_sl_return wr_sl_return_m1(
    .s1_AWREADY (s1_awready), 
    .s2_AWREADY (s2_awready), 
    .s1_WREADY  (s1_wready), 
    .s2_WREADY  (s2_wready), 
    .s1_BVALID  (s1_bvalid), 
    .s2_BVALID  (s2_bvalid), 
    .s1_BRESP   (s1_bresp), 
    .s2_BRESP   (s2_bresp), 
    .mas_sel1   (mas_sel_s1_wr), 
    .mas_sel2   (mas_sel_s2_wr),
    .wr_AWREADY (m1_awready), 
    .wr_WREADY  (m1_wready), 
    .wr_BVALID  (m1_bvalid),  
    .wr_BRESP   (m1_bresp)
);

wr_sl_return wr_sl_return_m2(
    .s1_AWREADY (s1_awready), 
    .s2_AWREADY (s2_awready), 
    .s1_WREADY  (s1_wready), 
    .s2_WREADY  (s2_wready), 
    .s1_BVALID  (s1_bvalid), 
    .s2_BVALID  (s2_bvalid), 
    .s1_BRESP   (s1_bresp), 
    .s2_BRESP   (s2_bresp), 
    .mas_sel1   (~mas_sel_s1_wr), 
    .mas_sel2   (~mas_sel_s2_wr),
    .wr_AWREADY (m2_awready), 
    .wr_WREADY  (m2_wready), 
    .wr_BVALID  (m2_bvalid),  
    .wr_BRESP   (m2_bresp)
);

rd_sl_return rd_sl_return_m1 (
    .s1_ARREADY (s1_arready), 
    .s2_ARREADY (s2_arready), 
    .s1_RLAST   (s1_rlast), 
    .s2_RLAST   (s2_rlast), 
    .s1_RVALID  (s1_rvalid), 
    .s2_RVALID  (s2_rvalid),
    .s1_RID     (s1_rid), 
    .s2_RID     (s2_rid), 
    .s1_RDATA   (s1_rdata), 
    .s2_RDATA   (s2_rdata),
    .s1_RRESP   (s1_rresp), 
    .s2_RRESP   (s2_rresp), 
    .mas_sel1   (mas_sel_s1_rd), 
    .mas_sel2   (mas_sel_s2_rd),
    .rd_ARREADY (m1_arready), 
    .rd_RLAST   (m1_rlast), 
    .rd_RVALID  (m1_rvalid),
    .rd_RID     (m1_rid), 
    .rd_RDATA   (m1_rdata),
    .rd_RRESP   (m1_rresp)
);

rd_sl_return rd_sl_return_m2 (
    .s1_ARREADY (s1_arready), 
    .s2_ARREADY (s2_arready), 
    .s1_RLAST   (s1_rlast), 
    .s2_RLAST   (s2_rlast), 
    .s1_RVALID  (s1_rvalid), 
    .s2_RVALID  (s2_rvalid),
    .s1_RID     (s1_rid), 
    .s2_RID     (s2_rid), 
    .s1_RDATA   (s1_rdata), 
    .s2_RDATA   (s2_rdata),
    .s1_RRESP   (s1_rresp), 
    .s2_RRESP   (s2_rresp), 
    .mas_sel1   (~mas_sel_s1_rd), 
    .mas_sel2   (~mas_sel_s2_rd),
    .rd_ARREADY (m2_arready), 
    .rd_RLAST   (m2_rlast), 
    .rd_RVALID  (m2_rvalid),
    .rd_RID     (m2_rid), 
    .rd_RDATA   (m2_rdata),
    .rd_RRESP   (m2_rresp)
);

scu scu_s1_wr (
    .clk        (i_clk), 
    .rstn       (i_rstn), 
    .sel_m1     (m1s1_wr_sel), 
    .sel_m2     (m2s1_wr_sel), 
    .endtrans_1 (m1_bready & m1_bvalid),
    .endtrans_2 (m2_bready & m2_bvalid), 
    .mas_sel    (mas_sel_s1_wr)
);

scu scu_s2_wr (
    .clk        (i_clk), 
    .rstn       (i_rstn), 
    .sel_m1     (m1s2_wr_sel), 
    .sel_m2     (m2s2_wr_sel), 
    .endtrans_1 (m1_bready & m1_bvalid),
    .endtrans_2 (m2_bready & m2_bvalid), 
    .mas_sel    (mas_sel_s2_wr)
);

scu scu_s1_rd (
    .clk        (i_clk), 
    .rstn       (i_rstn), 
    .sel_m1     (m1s1_rd_sel), 
    .sel_m2     (m2s1_rd_sel), 
    .endtrans_1 (s1_rlast),
    .endtrans_2 (s1_rlast), 
    .mas_sel    (mas_sel_s1_rd)
);

scu scu_s2_rd (
    .clk        (i_clk), 
    .rstn       (i_rstn), 
    .sel_m1     (m1s2_rd_sel), 
    .sel_m2     (m2s2_rd_sel), 
    .endtrans_1 (s2_rlast),
    .endtrans_2 (s2_rlast), 
    .mas_sel    (mas_sel_s2_rd)
);
    
// Slave 1 Write    
always@(*) begin
    case (mas_sel_s1_wr)
        2'b01: begin
            // Select Master 1
            // Write Address (AW)
            s1_awaddr  = m1s1_wr_addr;
            s1_awid    = m1_awid;
            s1_awlen   = m1_awlen;
            s1_awsize  = m1_awsize;
            s1_awburst = m1_awburst;
            s1_awlock  = m1_awlock;
            s1_awcache = m1_awcache;
            s1_awprot  = m1_awprot;
            s1_awvalid = m1_awvalid;
            // Write Data (W)
            s1_wdata   = m1_wdata;
            s1_wstrb   = m1_wstrb;
            s1_wlast   = m1_wlast;
            s1_wvalid  = m1_wvalid;
            // Write Response (B)
            s1_bid    = m1_bid;
            s1_bready  = m1_bready;
        end
        2'b10: begin
            // Select Master 2
            // Write Address (AW)
            s1_awaddr  = m2s1_wr_addr;
            s1_awid    = m2_awid;
            s1_awlen   = m2_awlen;
            s1_awsize  = m2_awsize;
            s1_awburst = m2_awburst;
            s1_awlock  = m2_awlock;
            s1_awcache = m2_awcache;
            s1_awprot  = m2_awprot;
            s1_awvalid = m2_awvalid;
            // Write Data (W)
            s1_wdata   = m2_wdata;
            s1_wstrb   = m2_wstrb;
            s1_wlast   = m2_wlast;
            s1_wvalid  = m2_wvalid;
            // Write Response (B)
            s1_bid    = m2_bid;
            s1_bready  = m2_bready;
        end
        default: begin
            // Slave 1
            // Write Address (AW)
            s1_awaddr  = 32'h0000_0000;
            s1_awid    = 8'b0000_0000;
            s1_awlen   = 8'b0000_0000;
            s1_awsize  = 3'b000;
            s1_awburst = 2'b00;
            s1_awlock  = 1'b0;
            s1_awcache = 4'b0000;
            s1_awprot  = 3'b000;
            s1_awvalid = 1'b0;
            // Write Data (W)
            s1_wdata  = 32'h0000_0000;
            s1_wstrb  = 4'b0000;
            s1_wlast  = 1'b0;
            s1_wvalid = 1'b0;
            // Write Response (B)
            s1_bid    = 8'b0000_0000;
            s1_bready = 1'b0;
        end
    endcase
end

// Slave 2 Write    
always@(*) begin
    case (mas_sel_s2_wr)
        2'b01: begin
            // Select Master 1
            // Write Address (AW)
            s2_awaddr  = m1s2_wr_addr;
            s2_awid    = m1_awid;
            s2_awlen   = m1_awlen;
            s2_awsize  = m1_awsize;
            s2_awburst = m1_awburst;
            s2_awlock  = m1_awlock;
            s2_awcache = m1_awcache;
            s2_awprot  = m1_awprot;
            s2_awvalid = m1_awvalid;
            // Write Data (W)
            s2_wdata   = m1_wdata;
            s2_wstrb   = m1_wstrb;
            s2_wlast   = m1_wlast;
            s2_wvalid  = m1_wvalid;
            // Write Response (B)
            s2_bid    = m1_bid;
            s2_bready  = m1_bready;
        end
        2'b10: begin
            // Select Master 2
            // Write Address (AW)
            s2_awaddr  = m2s2_wr_addr;
            s2_awid    = m2_awid;
            s2_awlen   = m2_awlen;
            s2_awsize  = m2_awsize;
            s2_awburst = m2_awburst;
            s2_awlock  = m2_awlock;
            s2_awcache = m2_awcache;
            s2_awprot  = m2_awprot;
            s2_awvalid = m2_awvalid;
            // Write Data (W)
            s2_wdata   = m2_wdata;
            s2_wstrb   = m2_wstrb;
            s2_wlast   = m2_wlast;
            s2_wvalid  = m2_wvalid;
            // Write Response (B)
            s2_bid    = m2_bid;
            s2_bready  = m2_bready;
        end
        default: begin
            // Write Address (AW)
            s2_awaddr  = 32'h0000_0000;
            s2_awid    = 8'b0000_0000;
            s2_awlen   = 8'b0000_0000;
            s2_awsize  = 3'b000;
            s2_awburst = 2'b00;
            s2_awlock  = 1'b0;
            s2_awcache = 4'b0000;
            s2_awprot  = 3'b000;
            s2_awvalid = 1'b0;
            // Write Data (W)
            s2_wdata  = 32'h0000_0000;
            s2_wstrb  = 4'b0000;
            s2_wlast  = 1'b0;
            s2_wvalid = 1'b0;
            // Write Response (B)
            s2_bid    = 8'b0000_0000;
            s2_bready = 1'b0;
        end
    endcase
end

// Slave 1 Read
always@(*) begin
    case (mas_sel_s1_rd)
        2'b01: begin
            // Select Master 1
            // Read Address (AR)
            s1_araddr  = m1s1_rd_addr;
            s1_arid    = m1_arid;
            s1_arlen   = m1_arlen;
            s1_arsize  = m1_arsize;
            s1_arburst = m1_arburst;
            s1_arlock  = m1_arlock;
            s1_arcache = m1_arcache;
            s1_arprot  = m1_arprot;
            s1_arvalid = m1_arvalid;
            // Read Data (R)
            s1_rready  = m1_rready;
        end
        2'b10: begin
            // Select Master 2
            // Read Address (AR)
            s1_araddr  = m2s1_rd_addr;
            s1_arid    = m2_arid;
            s1_arlen   = m2_arlen;
            s1_arsize  = m2_arsize;
            s1_arburst = m2_arburst;
            s1_arlock  = m2_arlock;
            s1_arcache = m2_arcache;
            s1_arprot  = m2_arprot;
            s1_arvalid = m2_arvalid;
            // Read Data (R)
            s1_rready  = m2_rready;
        end
        default: begin
            // Slave 1
            // Read Address (AR)
            s1_araddr  = 32'h0000_0000;
            s1_arid    = 8'b0000_0000;
            s1_arlen   = 8'b0000_0000;
            s1_arsize  = 3'b000;
            s1_arburst = 2'b00;
            s1_arlock  = 1'b0;
            s1_arcache = 4'b0000;
            s1_arprot  = 3'b000;
            s1_arvalid = 1'b0;
            // Read Data (R)
            s1_rready  = 1'b0;
        end
    endcase
end

// Slave 2 Read
always@(*) begin
    case (mas_sel_s2_rd)
        2'b01: begin
            // Select Master 1
            // Read Address (AR)
            s2_araddr  = m1s2_rd_addr;
            s2_arid    = m1_arid;
            s2_arlen   = m1_arlen;
            s2_arsize  = m1_arsize;
            s2_arburst = m1_arburst;
            s2_arlock  = m1_arlock;
            s2_arcache = m1_arcache;
            s2_arprot  = m1_arprot;
            s2_arvalid = m1_arvalid;
            // Read Data (R)
            s2_rready  = m1_rready;
        end
        2'b10: begin
            // Select Master 2
            // Read Address (AR)
            s2_araddr  = m2s2_rd_addr;
            s2_arid    = m2_arid;
            s2_arlen   = m2_arlen;
            s2_arsize  = m2_arsize;
            s2_arburst = m2_arburst;
            s2_arlock  = m2_arlock;
            s2_arcache = m2_arcache;
            s2_arprot  = m2_arprot;
            s2_arvalid = m2_arvalid;
            // Read Data (R)
            s2_rready  = m2_rready;
        end
        default: begin
            // Slave 2
            // Read Address (AR)
            s2_araddr  = 32'h0000_0000;
            s2_arid    = 8'b0000_0000;
            s2_arlen   = 8'b0000_0000;
            s2_arsize  = 3'b000;
            s2_arburst = 2'b00;
            s2_arlock  = 1'b0;
            s2_arcache = 4'b0000;
            s2_arprot  = 3'b000;
            s2_arvalid = 1'b0;
            // Read Data (R)
            s2_rready = 1'b0;
        end
    endcase
end

endmodule