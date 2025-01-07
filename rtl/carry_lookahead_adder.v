module carry_lookahead_adder #(
    parameter WIDTH = 16
) (
    input [WIDTH-1:0] 	a,
    input [WIDTH-1:0] 	b,
    input 				c_in,

    output [WIDTH-1:0] 	sum,
    output 				c_out,
    output              PG,
    output              CG
);

genvar i;

wire [3:0] P, G;
wire [4:0] C;

assign C[0] = c_in;
assign c_out = C[4];

generate
    if(WIDTH == 4) begin
        for(i=0; i<4;i=i+1) begin :CLA_1b
            CLA_1b cla_1b(
                .a      (a[i]),
                .b      (b[i]),
                .c_in   (C[i]),

                .p      (P[i]),
                .g      (G[i]),
                .sum    (sum[i])
            );
        end
    end else begin
        for(i=0; i<4; i=i+1) begin: carry_lookahead_adders
            carry_lookahead_adder #(WIDTH/4) carry_lookahead_adder_0 (
                .a      (a[i*WIDTH/4 +: WIDTH/4]),
                .b      (b[i*WIDTH/4 +: WIDTH/4]),
                .c_in   (C[i]),

                .sum    (sum[i*WIDTH/4 +: WIDTH/4]),
                .c_out  (),
                .PG     (P[i]),
                .CG     (G[i])
            );
            
        end
    end
endgenerate

lookahead la (
    .P      (P),
    .G      (G),
    .C_in   (c_in),

    .C      (C[4:1]),
    .PG     (PG),
    .CG     (CG)
);

endmodule


module CLA_1b (
    input a,
    input b,
    input c_in,

    output p,
    output g,
    output sum
);

    assign p = a ^ b;
    assign g = a & b;
    assign sum = (a ^ b) ^ c_in;

endmodule


module lookahead (
    input [3:0]     P,
    input [3:0]     G,
    input           C_in,

    output [3:0]    C,
    output          PG,
    output          CG
);

assign C[0] = G[0] | (P[0] & C_in);
assign C[1] = G[1] | (G[0] & P[1]) | (C_in & P[0] & P[1]);
assign C[2] = G[2] | (G[1] & P[2]) | (G[0] & P[1] & P[2]) | (C_in & P[0] & P[1] & P[2]);
assign C[3] = G[3] | (G[2] & P[3]) | (G[1] & P[2] & P[3]) | (G[0] & P[1] & P[2] & P[3]) | (C_in & P[0] & P[1] & P[2] & P[3]);

assign PG = &P;
assign CG = G[3] | (G[2] & P[3]) | (G[1] & P[3] & P[2]) | (G[0] & P[3] & P[2] & P[1]);

endmodule
