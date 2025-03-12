`timescale 1ns/1ps
module scu_tb();
    logic [0:0] sel_m1, sel_m2, endtrans;
    logic [1:0] mas_sel;
    logic i_clk, i_rstn;

    scu scu_inst (
        .clk          (i_clk),
        .rstn         (i_rstn),
        .sel_m1       (sel_m1),
        .sel_m2       (sel_m2),
        .endtrans     (endtrans),
        .mas_sel      (mas_sel)
    );

    // Clock gen
    initial begin
        i_clk = 0;
        forever #5 i_clk = ~i_clk;
    end

    initial begin
        i_rstn = 0;
        #10;
        i_rstn = 1;
    end

    // Wave dump
    initial begin
        $dumpfile("scu_tb.vcd");
        $dumpvars(0,scu_tb);      
    end

    int cnt = 1;
    initial begin
    // Initialize signals
        sel_m1 = 0;
        sel_m2 = 0;
        endtrans = 0;

        repeat (100) begin
            {sel_m1, sel_m2, endtrans} = $random % 8; 
            if (cnt != 0) #7.5;
            else #10;
            //#10; // Wait for FSM response
            $display("Time=%0.1f | sel_m1=%b | sel_m2=%b | endtrans=%b | mas_sel=%b  | state=%b", 
                     $realtime, sel_m1, sel_m2, endtrans, mas_sel, scu_inst.state);
            cnt = 0;
        end

        #10 $finish;
    end

endmodule