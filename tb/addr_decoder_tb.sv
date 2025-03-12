module addr_decoder_tb();
    logic [63:0] rd_addr, wr_addr;
    logic rd_slave1_sel, rd_slave2_sel, wr_slave1_sel, wr_slave2_sel;
    logic [63:0] s1_wr_addr, s2_wr_addr, s1_rd_addr, s2_rd_addr;
    logic i_clk;
    parameter S1_WIDTH = 64'd50;

    addr_decoder #(.S1_WIDTH (S1_WIDTH))
    addr_decoder_inst (
        .rd_addr        (rd_addr),
        .wr_addr        (wr_addr),
        .rd_slave1_sel  (rd_slave1_sel),
        .rd_slave2_sel  (rd_slave2_sel),
        .wr_slave1_sel  (wr_slave1_sel),
        .wr_slave2_sel  (wr_slave2_sel),
        .s1_wr_addr     (s1_wr_addr),
        .s2_wr_addr     (s2_wr_addr),
        .s1_rd_addr     (s1_rd_addr),
        .s2_rd_addr     (s2_rd_addr)
    );

    // Clock gen
    initial begin
        i_clk = 0;
        forever #5 i_clk = ~i_clk;
    end

    int count, error;
    initial begin
        count = 1;
        error = 0;
        
        repeat(1000)@(posedge i_clk) begin
            rd_addr = $urandom_range(0,100);
            wr_addr = $urandom_range(0,100);
            $display("\n#%0d",count++);
            #1
            if((rd_addr < S1_WIDTH) == rd_slave1_sel) $display("Correct rd slave1 sel"); else begin error++; $display("WRONG rd slave1 sel"); end
            if((wr_addr < S1_WIDTH) == wr_slave1_sel) $display("Correct wr slave1 sel"); else begin error++; $display("WRONG wr slave1 sel"); end

            if((rd_addr >= S1_WIDTH) == rd_slave2_sel) $display("Correct rd slave2 sel"); else begin error++; $display("WRONG rd slave2 sel"); end
            if((wr_addr >= S1_WIDTH) == wr_slave2_sel) $display("Correct wr slave2 sel"); else begin error++; $display("WRONG wr slave2 sel"); end

            if(s1_rd_addr != rd_addr) begin error++; $display("WRONG s1_rd_addr"); end else $display("Correct s1_rd_addr");
            if(s2_rd_addr != (rd_addr - S1_WIDTH)) begin error++; $display("WRONG s2_rd_addr"); end else $display("Correct s2_rd_addr");
            if(s1_wr_addr != wr_addr) begin error++; $display("WRONG s1_wr_addr"); end else $display("Correct s1_wr_addr");
            if(s2_wr_addr != (wr_addr - S1_WIDTH)) begin error++; $display("WRONG s2_wr_addr"); end else $display("Correct s2_wr_addr");
        end
        $display("\nERROR: %0d", error);
        $finish();
    end

    // Wave dump
    initial begin
        $dumpfile("addr_decoder_tb.vcd");
        $dumpvars(0,addr_decoder_tb);      
    end
    
endmodule