module half_adder (
    input a,
    input b,

    output sum,
    output c_out
);

/**
* sum = A xor B
* c_out = A and B
*/

assign sum = a ^ b;
assign c_out = a & b;

endmodule