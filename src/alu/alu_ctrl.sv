`timescale 1ns/1ps

import alu_common::*;

module alu_ctrl (
    input logic clk,
    input logic rst,
    input logic enter, //From edge detector 
    input logic sign, //From edge dete
    output alu_op_t fn,
    output logic [1:0] reg_ctrl
    );

    alu_op_t state, state_next; 
    logic signed_state, signed_state_next; 

    always_ff @(posedge clk  or negedge rst) begin
        if(rst == 0) begin
            state <= INPUT_A;
            signed_state <= '0;
        end else begin
            state <= state_next;
            signed_state <= signed_state_next; 
        end 
    end

    always_comb begin : signed_toggle_block
        signed_state_next = signed_state;
        if(sign == 1) signed_state_next = ~signed_state;
    end

    always_comb begin
        state_next = state;
        reg_ctrl = '0; //Default

        case (state)
            INPUT_A : begin
                reg_ctrl = 2'b10;
                if(enter == 1) state_next = INPUT_B;
            end
            INPUT_B : begin
                reg_ctrl = 2'b11;
                if(enter == 1) begin
                    if(signed_state == 1) state_next = S_ADD;
                    else state_next = U_ADD;
                end
            end
            U_ADD : begin
                if(enter == 1) begin
                    if(signed_state == 1) state_next = S_SUB;
                    else state_next = U_SUB;
                end else if(signed_state == 1) state_next = S_ADD;
            end 
            U_SUB : begin
                if(enter == 1) begin
                    if(signed_state == 1) state_next = S_MOD3;
                    else state_next = U_MOD3; 
                end else if(signed_state == 1) state_next = S_SUB;
            end 
            U_MOD3 : begin
                if(enter == 1) begin
                    if(signed_state == 1) state_next = S_ADD;
                    else state_next = U_ADD; 
                end else if(signed_state == 1) state_next = S_MOD3;                
            end 
            S_ADD : begin
                if(enter == 1) begin
                    if(signed_state == 1) state_next = S_SUB;
                    else state_next = U_SUB;
                end else if(signed_state == 0) state_next = U_ADD;
            end
            S_SUB : begin
                if(enter == 1) begin
                    if(signed_state == 1) state_next = S_MOD3;
                    else state_next = U_MOD3; 
                end else if(signed_state == 0) state_next = U_SUB;
            end
            S_MOD3 : begin
                if(enter == 1) begin
                    if(signed_state == 1) state_next = S_ADD;
                    else state_next = U_ADD; 
                end else if(signed_state == 0) state_next = U_MOD3;                
            end 
        endcase
    end

    assign fn = state;

endmodule
