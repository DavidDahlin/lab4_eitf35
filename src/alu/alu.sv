`timescale 1ns/1ps

module alu (
    input logic [7:0] a,
    input logic [7:0] b,
    input logic [7:0] op,
    output logic [7:0] result,
    output logic overflow,
    output logic sign
    );

    logic [7:0] res_mod, res_arith;
    logic sign_internal;
    logic mod_enable;
    
    mod3 mod3_inst (
        .a(a),
        .op(op),
        .result(res_mod)
    );

    arithmetic arithmetic_inst (
        .a(a),
        .b(b),
        .op(op),
        .result(res_arith),
        .overflow(overflow),
        .sign(sign)
    );

    assign result = res_arith | res_mod;

endmodule
