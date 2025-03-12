module comparator_tb();
    logic [31:0] rs1_data, rs2_data;
    logic [0:0]  less, equal, i_clk;

    comparator comparator_inst1 (
        .rs1_data(rs1_data),
        .rs2_data(rs2_data),
        .less(less),
        .equal(equal)
    );

    // Clock gen
    initial begin
        i_clk = 0;
        forever #5 i_clk = ~i_clk;
    end
    int count;
    initial begin
        count = 1;
        
        repeat(10)@(posedge i_clk) begin
            rs1_data = $urandom_range(0,10);
            rs2_data = $urandom_range(0,10);
            $display("\n#%0d",count++);
            #1
            if (equal == (rs1_data != rs2_data)) $display("Error at equal"); //else $display("Correct equal");
            if (less == (rs1_data >= rs2_data)) $display("Error at less %0d %0d %0d",rs1_data,rs2_data,less); //else $display("Correct less");
        end
        $finish();
    end

    // Wave dump
    initial begin
        $dumpfile("comparator_tb.vcd");
        $dumpvars(0,comparator_tb);      
    end
    
endmodule