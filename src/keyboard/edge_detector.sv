// TITLE: edge_detector.sv
// PROJECT: Keyboard VLSI lab
// DESCRIPTION: Make sure not to use posedge/negedge on any other signal than clk

`timescale 1ns/1ps

module edge_detector (
    input logic clk,
    input logic rst,
    input logic signal,
    output logic edge_found
    );

    logic edge_previous, edge_found_internal;

    always_ff @(posedge clk or negedge rst) begin
        if(rst == 0) begin
            edge_previous <= 0;
            edge_found <= 0;
        end else begin
            edge_previous <= signal;
            edge_found <= edge_found_internal;
        end
    end
    
    assign edge_found_internal = ~signal & edge_previous;
        
endmodule
