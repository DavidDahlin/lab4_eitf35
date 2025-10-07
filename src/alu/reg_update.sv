`timescale 1ns/1ps

module reg_update (
    input logic clk,
    input logic rst,
    input logic [1:0] reg_ctrl,
    input logic [7:0] reg_input,
    output logic [7:0] a,
    output logic [7:0] b
    );

    logic [7:0] a_internal_next, a_internal, b_internal_next, b_internal;

    always_ff @(posedge clk or negedge rst) begin
        if(rst == 0) begin
            a_internal <= '0;
            b_internal <= '0;
        end else begin
            a_internal <= a_internal_next;
            b_internal <= b_internal_next;
        end
    end

    always_comb begin : input_logic
        // defaults
        a_internal_next = a_internal;
        b_internal_next = b_internal;

        if(reg_ctrl[1] == 1) begin
            if(reg_ctrl[0] == 0) begin
                a_internal_next = reg_input;
            end else begin
                b_internal_next = reg_input;
            end
        end
    end

    assign a = a_internal;
    assign b = b_internal;

endmodule
