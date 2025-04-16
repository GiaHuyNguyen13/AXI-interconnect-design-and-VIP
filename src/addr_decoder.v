module addr_decoder(
    input wire [31:0] rd_addr, wr_addr,
    input wire        rd_addr_valid, wr_addr_valid,
    output wire rd_slave1_sel, rd_slave2_sel, wr_slave1_sel, wr_slave2_sel, 
    output wire [31:0] s1_wr_addr, s2_wr_addr, s1_rd_addr, s2_rd_addr
);

//parameter S1_WIDTH = 32'h8000_0000;
parameter S1_WIDTH = 32'h0000_0200;  //512
wire rd_less, rd_equal, wr_less, wr_equal, rd_gr_eq, wr_gr_eq;

comparator comp_rd (
    .rs1_data(rd_addr),
    .rs2_data(S1_WIDTH),
    .less(rd_less),
    .equal(rd_equal)
);

comparator comp_wr (
    .rs1_data(wr_addr),
    .rs2_data(S1_WIDTH),
    .less(wr_less),
    .equal(wr_equal)
);

assign rd_gr_eq = ~rd_less;
assign wr_gr_eq = ~wr_less;

assign rd_slave1_sel = rd_less & rd_addr_valid;
assign rd_slave2_sel = rd_gr_eq & rd_addr_valid;

assign wr_slave1_sel = wr_less & wr_addr_valid;
assign wr_slave2_sel = wr_gr_eq & wr_addr_valid;

assign s1_rd_addr = rd_addr;
assign s2_rd_addr = rd_addr - S1_WIDTH;

assign s1_wr_addr = wr_addr;
assign s2_wr_addr = wr_addr - S1_WIDTH;
    
endmodule