module rd_sl_return(
    input  wire         s1_ARREADY, s2_ARREADY, s1_RLAST, s2_RLAST, 
                        s1_RVALID, s2_RVALID,
    input  wire [7:0]   s1_RID, s2_RID,
    input  wire [31:0]  s1_RDATA, s2_RDATA,
    input  wire [1:0]   s1_RRESP, s2_RRESP,
    input  wire [1:0]   mas_sel1, mas_sel2,

    output reg          rd_ARREADY, rd_RLAST, rd_RVALID, 
    output reg  [7:0]   rd_RID,
    output reg  [31:0]  rd_RDATA,
    output reg  [1:0]   rd_RRESP
);

wire s1_resp, s2_resp;

assign s1_resp = mas_sel1[0] & ~mas_sel1[1];
assign s2_resp = mas_sel2[0] & ~mas_sel2[1];

always @(*) begin
    case({s2_resp,s1_resp})
        2'b01: begin
            rd_ARREADY = s1_ARREADY;
            rd_RLAST   = s1_RLAST;
            rd_RVALID  = s1_RVALID;
            rd_RID     = s1_RID;
            rd_RDATA   = s1_RDATA;
            rd_RRESP   = s1_RRESP;
        end

        2'b10: begin
            rd_ARREADY = s2_ARREADY;
            rd_RLAST   = s2_RLAST;
            rd_RVALID  = s2_RVALID;
            rd_RID     = s2_RID;
            rd_RDATA   = s2_RDATA;
            rd_RRESP   = s2_RRESP;
        end

        default: begin
            rd_ARREADY = 1'b0;
            rd_RLAST   = 1'b0;
            rd_RVALID  = 1'b0;
            rd_RID     = 8'b0;
            rd_RDATA   = 32'b0;
            rd_RRESP   = 2'b0;
        end
    endcase
end
    
endmodule