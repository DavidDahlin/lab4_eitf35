`timescale 1ns/1ps

import alu_common::*;

module mod3 (
    input logic [7:0] a,
    input alu_op_t fn,
    output logic [7:0] result
    );

    logic [1:0] node_1, node_2, node_3, node_4, node_5, node_end, mid_step;

    
    mod3_component mod3_component_1(
        .in(a[7:5]),
        .out(node_1)
    );

    mod3_component mod3_component_2(
        .in({node_1,a[4]}),
        .out(node_2)
    );

    mod3_component mod3_component_3(
        .in({node_2,a[3]}),
        .out(node_3)
    );
    
    mod3_component mod3_component_4(
        .in({node_3,a[2]}),
        .out(node_4)
    );

    mod3_component mod3_component_5(
        .in({node_4,a[1]}),
        .out(node_5)
    );

    mod3_component mod3_component_6(
        .in({node_5,a[0]}),
        .out(node_end)
    );

    always_comb begin
        result = {6'd0, node_end}; //Default

        if (fn == S_MOD3 && a[7] == 1 ) begin
            if(node_end == 1) result = {6'd0, 2'd0};
            else if(node_end == 2) result = {6'd0, 2'd1};
            else result = {6'd0, 2'd2};
        end
    end

endmodule