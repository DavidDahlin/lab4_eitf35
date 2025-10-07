`timescale 1ns/1ps

import alu_common::*;

module alu (
    input logic [7:0] a,
    input logic [7:0] b,
    input alu_op_t fn,
    output logic [7:0] result,
    output logic overflow,
    output logic sign
    );

    logic [7:0] res_mod, res_arith;
    logic sign_internal;
    
    mod3 mod3_inst (
        .a(a),
        .fn(fn),
        .result(res_mod)
    );

    arithmetic arithmetic_inst (
        .a(a),
        .b(b),
        .fn(fn),
        .result(res_arith),
        .overflow(overflow),
        .sign(sign_internal)
    );

    always_comb begin
        result = 8'h00;
        sign = 1'b0;
        
        case(fn)
            INPUT_A : result = a;
            INPUT_B : result = b;
            U_MOD3 : result = res_mod;
            S_MOD3 : result = res_mod;
            default : begin
                result = res_arith;
                sign = sign_internal;
            end
        endcase

    end

endmodule
