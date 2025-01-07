module full_adder (
    input a,
    input b,
    input c_in,

    output sum,
    output c_out
);

/**
* sum = (A xor B) xor C_in
* c_out = (A and B) or ((A xor B) and C)
*/

assign sum = (a ^ b) ^ c_in;
assign c_out = (a & b) | ((a ^ b) & c_in);

endmodule