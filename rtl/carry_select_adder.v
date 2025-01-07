module carry_select_adder #(
    parameter WIDTH = 8
) (
    input [WIDTH-1:0] 	a,
    input [WIDTH-1:0] 	b,
    input 				c_in,

    output [WIDTH-1:0] 	sum,
    output 				c_out
);

generate
    if(WIDTH == 1) begin
        full_adder FA (
            .a      (a),
            .b      (b),
            .c_in   (c_in),

            .sum    (sum),
            .c_out  (c_out)
        );
    end else begin
        wire [WIDTH/2-1:0] sum_0, sum_1;
        wire c_out_temp, c_out_0, c_out_1;

        carry_select_adder #(WIDTH/2) CSA (
            .a      (a[WIDTH/2-1:0]),
            .b      (b[WIDTH/2-1:0]),
            .c_in   (c_in),

            .sum    (sum[WIDTH/2-1:0]),
            .c_out  (c_out_temp)
        );

        carry_select_adder #(WIDTH/2) CSA_carry_0 (
            .a      (a[WIDTH-1:WIDTH/2]),
            .b      (b[WIDTH-1:WIDTH/2]),
            .c_in   (1'b0),

            .sum    (sum_0),
            .c_out  (c_out_0)
        );

        carry_select_adder #(WIDTH/2) CSA_carry_1 (
            .a      (a[WIDTH-1:WIDTH/2]),
            .b      (b[WIDTH-1:WIDTH/2]),
            .c_in   (1'b1),

            .sum    (sum_1),
            .c_out  (c_out_1)
        );

        assign sum[WIDTH-1:WIDTH/2] = c_out_temp ? sum_1 : sum_0;
        assign c_out = c_out_temp ? c_out_1 : c_out_0;
    end
endgenerate


endmodule