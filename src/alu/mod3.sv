`timescale 1ns/1ps


module mod3 (
    input logic [7:0] a,
    input logic [7:0] op,
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

    assign result = op == 8'd133 ? {6'd0, node_end} : 8'h00;

endmodule