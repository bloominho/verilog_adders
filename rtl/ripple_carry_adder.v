module ripple_carry_adder #(
    parameter WIDTH = 8
) (
    input [WIDTH-1:0] 	a,
    input [WIDTH-1:0] 	b,
    input 				c_in,

    output [WIDTH-1:0] 	sum,
    output 				c_out
);

wire [WIDTH:0] carry;
assign carry[0] = c_in;
assign c_out = carry[WIDTH];

genvar i;
generate
    for(i=0; i<WIDTH; i=i+1) begin: full_adders
        full_adder FA (
            .a      (a[i]),
            .b      (b[i]),
            .c_in   (carry[i]),

            .sum    (sum[i]),
            .c_out  (carry[i+1])
        );
    end
endgenerate


endmodule