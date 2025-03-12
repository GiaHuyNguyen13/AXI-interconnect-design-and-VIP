module rd_sl_return_tb();
    // Input wire declarations
    wire         s1_ARREADY, s2_ARREADY, s1_RLAST, s2_RLAST;
    wire         s1_RVALID, s2_RVALID;
    wire [63:0]  s1_RID, s2_RID, s1_RDATA, s2_RDATA;
    wire [1:0]   s1_RRESP, s2_RRESP;
    reg [1:0]   mas_sel1, mas_sel2;

    // Output wire declarations
    wire         rd_ARREADY, rd_RLAST, rd_RVALID;
    wire [63:0]  rd_RID, rd_RDATA;
    wire [1:0]   rd_RRESP;

    reg i_clk;

    assign s1_ARREADY = 1'b0;
    assign s2_ARREADY = 1'b1;
    assign s1_RLAST   = 1'b0;
    assign s2_RLAST   = 1'b1;
    assign s1_RVALID  = 1'b0;
    assign s2_RVALID  = 1'b1;

    assign s1_RID     = 64'h0000000000000000;
    assign s2_RID     = 64'h0000000000000001;
    assign s1_RDATA   = 64'h0000000000000000;
    assign s2_RDATA   = 64'h0000000000000001;

    assign s1_RRESP   = 2'b00;
    assign s2_RRESP   = 2'b01;

    rd_sl_return ins1 (
    .s1_ARREADY(s1_ARREADY),
    .s2_ARREADY(s2_ARREADY),
    .s1_RLAST(s1_RLAST),
    .s2_RLAST(s2_RLAST),
    .s1_RVALID(s1_RVALID),
    .s2_RVALID(s2_RVALID),
    .s1_RID(s1_RID),
    .s2_RID(s2_RID),
    .s1_RDATA(s1_RDATA),
    .s2_RDATA(s2_RDATA),
    .s1_RRESP(s1_RRESP),
    .s2_RRESP(s2_RRESP),
    .mas_sel1(mas_sel1),
    .mas_sel2(mas_sel2),

    .rd_ARREADY(rd_ARREADY),
    .rd_RLAST(rd_RLAST),
    .rd_RVALID(rd_RVALID),
    .rd_RID(rd_RID),
    .rd_RDATA(rd_RDATA),
    .rd_RRESP(rd_RRESP)
);


    // Clock gen
    initial begin
        i_clk = 0;
        forever #5 i_clk = ~i_clk;
    end
    int count, err;

    assign mas_sel2 = ~mas_sel1;

    wire s1_resp, s2_resp;
    assign s1_resp = mas_sel1[0] & ~mas_sel1[1];
    assign s2_resp = mas_sel2[0] & ~mas_sel2[1];

    initial begin
        count = 1;
        err = 0;
        
        repeat(10)@(posedge i_clk) begin
            mas_sel1 = $urandom_range(0,3);
            $display("\n#%0d",count++);
            #1
            if ({s2_resp,s1_resp} == 2'b01 && ((rd_ARREADY != 1'b0) || 
                                              (rd_RLAST   != 1'b0)  || 
                                              (rd_RVALID  != 1'b0)  || 
                                              (rd_RID     != 64'b0) || 
                                              (rd_RDATA   != 64'b0) || 
                                              (rd_RRESP   != 2'b00))) 
                begin $display("Wrong sel slave 1"); err++; end

            if ({s2_resp,s1_resp} == 2'b10 && ((rd_ARREADY != 1'b1) || 
                                              (rd_RLAST   != 1'b1)  || 
                                              (rd_RVALID  != 1'b1)  || 
                                              (rd_RID     != 64'b1) || 
                                              (rd_RDATA   != 64'b1) || 
                                              (rd_RRESP   != 2'b01))) 
                begin $display("Wrong sel slave 2"); err++; end
                    
            

            
        end
        $display("Err: %0d",err);
        $finish();
    end

    // Wave dump
    initial begin
        $dumpfile("rd_sl_return_tb.vcd");
        $dumpvars(0,rd_sl_return_tb);      
    end
    
endmodule