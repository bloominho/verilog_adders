# Verilog Adders

This repository provides various types of adders written in verilog. 

The types of adders that this repository provides are:
- Half Adder
- Full Adder
- Ripple Carry Adder
- Carry Lookahead Adder
- Carry Select Adder
- Koggie Stone Adder

The adders shared a basic format. You can change the type of adder by only changing the name of the adder. These adders can all used in various sizes. The number of bits can be declared using parameters.

__Basic Format__
> _Name_of_Adder_  #( .WIDTH( _WIDTH_SIZE_ ) ) _Name_of_Module_ ( .A( _Input_1_ ),
 .B( _Input_2_ ),
 .c_in( _Carry_In_ ),
 .sum( _Sum_Result_ ),
 .c_out( _Carry_Out_ )
)

These adders are checked for accuracy and given accurate results for the ones that are tested (until now).

These adders can be synthesized.

## Credits
Jan-Feb 2025, Andrew Park