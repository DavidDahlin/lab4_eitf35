`timescale 1ns/1ps

import alu_common::*;

module alu_top (
    input logic clk,
    input logic rst,
    input logic b_enter,
    input logic b_sign,
    input logic [7:0] alu_input,
    output logic [7:0] seven_seg,
    output logic [3:0] anode
    );

    // SIGNAL DEFINITIONS
    logic enter;
    logic sign;
    logic enter_edge;
    logic sign_edge;

    debouncer debouncer_enter (
        .clk(clk),
        .rst(rst),
        .button_in(b_enter),
        .button_out(enter)
    );

    debouncer debouncer_sign (
        .clk(clk),
        .rst(rst),
        .button_in(b_sign),
        .button_out(sign)
    );

    edge_detector edge_detect_enter (
        .clk(clk),
        .rst(rst),
        .in(enter),
        .edge_found(enter_edge)
    );

    edge_detector edge_detect_sign (
        .clk(clk),
        .rst(rst),
        .in(sign),
        .edge_found(sign_edge)
    );

    alu_op_t fn;
    logic [1:0] reg_ctrl;

    alu_ctrl alu_controler (
        .clk(clk),
        .rst(rst),
        .enter(enter_edge),
        .sign(sign_edge),
        .fn(fn),
        .reg_ctrl(reg_ctrl)
    );

    logic [7:0] a;
    logic [7:0] b;

    reg_update register_update(
        .clk(clk),
        .rst(rst),
        .reg_ctrl(reg_ctrl),
        .reg_input(alu_input),
        .a(a),
        .b(b)
    );

    logic [7:0] result;
    logic overflow;
    logic sign_for_display;

    alu alu_module (
        .a(a),
        .b(b),
        .fn(fn),
        .result(result),
        .overflow(overflow),
        .sign(sign_for_display)
    );

    logic [9:0] bcd_out;

    binary2bcd binary_2_bcd (
        .binary_in(result),
        .bcd_out(bcd_out)
    );


    seven_seg_driver seven_segment_driver (
        .clk(clk),
        .rst(rst),
        .bcd_digit(bcd_out),
        .sign(sign_for_display),
        .overflow(overflow),
        .digit_anode(anode),
        .segment(seven_seg)
    );

      
endmodule
