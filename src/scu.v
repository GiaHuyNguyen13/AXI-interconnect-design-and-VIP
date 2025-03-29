module scu (
    input  wire [0:0] clk, rstn,
    input  wire [0:0] sel_m1, sel_m2, endtrans_1, endtrans_2,
    output reg  [1:0] mas_sel
);
    //States
    localparam START  = 2'b00;
    localparam GRANT1 = 2'b01;
    localparam GRANT2 = 2'b10;
    localparam NEXT   = 2'b11;
    //Internal signals
    reg [1:0] state, next_state;
    reg [0:0] next_gr;

    always@(posedge clk or negedge rstn) begin
        if(!rstn)
            state <= START;
        else
            state <= next_state; 
    end

    always@(*) begin
        case(state)
            START:  begin
                if (sel_m1 == 1'b1)
                    next_state = GRANT1;
                else if (sel_m2 == 1'b1)
                    next_state = GRANT2;
                else
                    next_state = state;
            end
            GRANT1: begin
                if (endtrans_1 == 1'b1)
                    next_state = NEXT;
                else
                    next_state = state;
            end
            GRANT2: begin
                if (endtrans_2 == 1'b1)
                    next_state = NEXT;
                else
                    next_state = state;
            end
            NEXT:   begin
                if (sel_m1 == 1'b1 && sel_m2 == 1'b1 && next_gr == 1'b0)
                    next_state = GRANT1;
                else if (sel_m1 == 1'b1 && sel_m2 == 1'b1 && next_gr == 1'b1)
                    next_state = GRANT2;
                else if (sel_m1 == 1'b1)
                    next_state = GRANT1;
                else if (sel_m2 == 1'b1)
                    next_state = GRANT2;
                else
                    next_state = state;
                // if ((sel_m1 == 1'b1 && sel_m2 == 1'b0) || (sel_m1 == 1'b1 && sel_m2 == 1'b1 && next_gr == 1'b0))
                //     next_state = GRANT1;
                // else if ((sel_m1 == 1'b0 && sel_m2 == 1'b1) || (sel_m1 == 1'b1 && sel_m2 == 1'b1 && next_gr == 1'b1))
                //     next_state = GRANT2;
                // else
                //     next_state = state;
            end
            default: next_state = START;
        endcase
    end

    always@(*) begin
        case(state)
            START:  begin
                mas_sel = 2'b00;
                next_gr = 1'b0;
            end
            GRANT1: begin
                mas_sel = 2'b01;
                next_gr = 1'b1;
            end
            GRANT2: begin
                mas_sel = 2'b10;
                next_gr = 1'b0;
            end
            NEXT: mas_sel = 2'b00;
            default: begin
                mas_sel = 2'b10;
                next_gr = 1'b0;
            end
        endcase
    end

endmodule