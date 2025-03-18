module comparator (
    input  wire [31:0] rs1_data, rs2_data,
    output wire  [0:0]  less, equal
);
    wire [31:0] sub, not_b;
    wire overflow, carry;
    // logic [0:0] br_equal_reg, br_less_reg;
    
    assign not_b = ~rs2_data;
    assign {carry,sub} = rs1_data + not_b + 32'b1;
    assign overflow = (rs1_data[31] ^ rs2_data[31]) & (rs1_data[31] ^ sub[31]); 

    assign less = ~carry;
    assign equal = (!sub) ? 1 : 0;
endmodule