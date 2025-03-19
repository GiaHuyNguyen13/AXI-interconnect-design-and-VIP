module wr_sl_return(
    input  wire         s1_AWREADY, s2_AWREADY, s1_WREADY, s2_WREADY, 
                        s1_BVALID, s2_BVALID,
    input  wire [1:0]   s1_BRESP, s2_BRESP, mas_sel1, mas_sel2,

    output reg         wr_AWREADY, wr_WREADY, wr_BVALID,  
    output reg [1:0]   wr_BRESP
);

wire s1_resp, s2_resp;

assign s1_resp = mas_sel1[0] & ~mas_sel1[1];
assign s2_resp = mas_sel2[0] & ~mas_sel2[1];

always @(*) begin
    case({s2_resp,s1_resp})
        2'b01: begin
            wr_AWREADY = s1_AWREADY;
            wr_WREADY  = s1_WREADY;
            wr_BVALID  = s1_BVALID;
            wr_BRESP   = s1_BRESP;
        end

        2'b10: begin
            wr_AWREADY = s2_AWREADY;
            wr_WREADY  = s2_WREADY;
            wr_BVALID  = s2_BVALID;
            wr_BRESP   = s2_BRESP;
        end

        default: begin
            wr_AWREADY = 1'b0;
            wr_WREADY  = 1'b0;
            wr_BVALID  = 1'b0;
            wr_BRESP   = 2'b0;
        end
    endcase
end
    
endmodule