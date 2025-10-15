`timescale 1ns / 1ps


module display_top(
    // top level signals
    input logic clk,
    input logic rst,

    // Display inputs
    input logic[7:0] a,
    input logic[7:0] b,

    input logic[7:0] result,
    input logic sign,
    
    input logic[7:0] operand,

    // Control signals
    input logic valid,

    // Outputs
    output logic[11:0] io_rgb_color,
    output logic io_horizontal_sync,
    output logic io_vertical_sync

); 
    logic [10:0] x,y;
    logic is_displaying_pixels;
    logic [9:0] bcd_number_1, bcd_number_2, bcd_number_3;

    // ************** TIMING CONTROL ***************
    vga_controller vga_controller(
        .clk(clk),
        .rst(rst),
        .io_horizontal_sync(io_horizontal_sync),
        .io_vertical_sync(io_vertical_sync),
        .is_drawing(is_displaying_pixels),
        .x(x),
        .y(y)
    );

    // ************** BIN -> BCD ***************
    binary2bcd dubdab_a (
        .binary_in(a),
        .bcd_out(bcd_number_1)
    );
    binary2bcd dubdab_b (
        .binary_in(b),
        .bcd_out(bcd_number_2)
    );
    binary2bcd dubdab_res (
        .binary_in(result),
        .bcd_out(bcd_number_3)
    );


    // ************** BIN -> SG ***************
    logic [7:0] sev_seg_a0, sev_seg_a1, sev_seg_a2;
    logic [7:0] sev_seg_b0, sev_seg_b1, sev_seg_b2;
    logic [7:0] sev_seg_r0, sev_seg_r1, sev_seg_r2;

    binary_to_sg b2sg_a0 (
        .binary_in({2'b00,bcd_number_1[9:8]}),
        .sev_seg(sev_seg_a0)
    );
    binary_to_sg b2sg_a1 (
        .binary_in(bcd_number_1[7:4]),
        .sev_seg(sev_seg_a1)
    );
    binary_to_sg b2sg_a2 (
        .binary_in(bcd_number_1[3:0]),
        .sev_seg(sev_seg_a2)
    );


    binary_to_sg b2sg_b0 (
        .binary_in({2'b00,bcd_number_2[9:8]}),
        .sev_seg(sev_seg_b0)
    );
    binary_to_sg b2sg_b1 (
        .binary_in(bcd_number_2[7:4]),
        .sev_seg(sev_seg_b1)
    );
    binary_to_sg b2sg_b2 (
        .binary_in(bcd_number_2[3:0]),
        .sev_seg(sev_seg_b2)
    );


    binary_to_sg b2sg_r0 (
        .binary_in({2'b00,bcd_number_3[9:8]}),
        .sev_seg(sev_seg_r0)
    );
    binary_to_sg b2sg_r1 (
        .binary_in(bcd_number_3[7:4]),
        .sev_seg(sev_seg_r1)
    );
    binary_to_sg b2sg_r2 (
        .binary_in(bcd_number_3[3:0]),
        .sev_seg(sev_seg_r2)
    );



    // ************** DRAWING ***************
    logic [11:0] io_rgb_color_0, io_rgb_color_1, io_rgb_color_2, io_rgb_color_3, io_rgb_color_4, io_rgb_color_5,io_rgb_color_6, io_rgb_color_7, io_rgb_color_8, io_rgb_color_9, io_rgb_color_10, io_rgb_color_11;

    seven_seg_drawer #(
        .X_OFFSET(30)
    ) drawer_0 (
        .x(x),
        .y(y),
        .is_displaying_pixels(is_displaying_pixels),
        .sev_seg(sev_seg_a0),
        .io_rgb_color(io_rgb_color_0)
    );

    seven_seg_drawer #(
        .X_OFFSET(80)
    ) drawer_1 (
        .x(x),
        .y(y),
        .is_displaying_pixels(is_displaying_pixels),
        .sev_seg(sev_seg_a1),
        .io_rgb_color(io_rgb_color_1)
    );

    seven_seg_drawer #(
        .X_OFFSET(130)
    ) drawer_2 (
        .x(x),
        .y(y),
        .is_displaying_pixels(is_displaying_pixels),
        .sev_seg(sev_seg_a2),
        .io_rgb_color(io_rgb_color_2)
    );

    op_drawer #(
        .X_OFFSET(180)
    ) drawer_3 (
        .x(x),
        .y(y),
        .is_displaying_pixels(is_displaying_pixels),
        .op(operand),
        .io_rgb_color(io_rgb_color_3)
    );

    seven_seg_drawer #(
        .X_OFFSET(230)
    ) drawer_4 (
        .x(x),
        .y(y),
        .is_displaying_pixels(is_displaying_pixels),
        .sev_seg(sev_seg_b0),
        .io_rgb_color(io_rgb_color_4)
    );

    seven_seg_drawer #(
        .X_OFFSET(280)
    ) drawer_5 (
        .x(x),
        .y(y),
        .is_displaying_pixels(is_displaying_pixels),
        .sev_seg(sev_seg_b1),
        .io_rgb_color(io_rgb_color_5)
    );

    seven_seg_drawer #(
        .X_OFFSET(330)
    ) drawer_6 (
        .x(x),
        .y(y),
        .is_displaying_pixels(is_displaying_pixels),
        .sev_seg(sev_seg_b2),
        .io_rgb_color(io_rgb_color_6)
    );

    eq_drawer #(
        .X_OFFSET(380)
    ) drawer_7 (
        .x(x),
        .y(y),
        .is_displaying_pixels(is_displaying_pixels),
        .io_rgb_color(io_rgb_color_7)
    );

    logic [7:0] res_sign;

    assign res_sign = sign == 0 ? 8'h0b : 8'h0a;

    op_drawer #(
        .X_OFFSET(430)
    ) drawer_8 (
        .x(x),
        .y(y),
        .is_displaying_pixels(is_displaying_pixels),
        .op(res_sign),
        .io_rgb_color(io_rgb_color_8)
    );

    seven_seg_drawer #(
        .X_OFFSET(480)
    ) drawer_9 (
        .x(x),
        .y(y),
        .is_displaying_pixels(is_displaying_pixels),
        .sev_seg(sev_seg_r0),
        .io_rgb_color(io_rgb_color_9)
    );

    seven_seg_drawer #(
        .X_OFFSET(530)
    ) drawer_10 (
        .x(x),
        .y(y),
        .is_displaying_pixels(is_displaying_pixels),
        .sev_seg(sev_seg_r1),
        .io_rgb_color(io_rgb_color_10)
    );

    seven_seg_drawer #(
        .X_OFFSET(580)
    ) drawer_11 (
        .x(x),
        .y(y),
        .is_displaying_pixels(is_displaying_pixels),
        .sev_seg(sev_seg_r2),
        .io_rgb_color(io_rgb_color_11)
    );

    assign io_rgb_color = io_rgb_color_0 | io_rgb_color_1 | io_rgb_color_2 | io_rgb_color_3 | io_rgb_color_4 | io_rgb_color_5 | io_rgb_color_6 | io_rgb_color_7 | io_rgb_color_8 | io_rgb_color_9 | io_rgb_color_10 | io_rgb_color_11;
    
endmodule