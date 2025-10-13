`timescale 1ns / 1ps


module display_top(
    // top level signals
    input logic clk,
    input logic reset_n,

    // Display inputs
    // input logic[7:0] a,
    // input logic[7:0] b,
    // input logic[7:0] result,
    // input logic[3:0] operand,

    input logic [7:0] number, 

    // Control signals
    // input logic valid,

    // Outputs
    output logic[11:0] io_rgb_color,
    output logic io_horizontal_sync,
    output logic io_vertical_sync

); 

    logic [11:0] io_rgb_color_0, io_rgb_color_1, io_rgb_color_2;

    logic [10:0] x,y;
    logic is_displaying_pixels;

    logic [9:0] bcd_number;

    vga_controller vga_controller(
        .clk(clk),
        .reset_n(reset_n),
        .io_horizontal_sync(io_horizontal_sync),
        .io_vertical_sync(io_vertical_sync),
        .is_drawing(is_displaying_pixels),
        .x(x),
        .y(y)
    );

    binary2bcd dubdab (
        .binary_in(number),
        .bcd_out(bcd_number)
    );

    logic [7:0] sev_seg_0, sev_seg_1, sev_seg_2;

    binary_to_sg b2sg_0 (
        .binary_in({2'b00,bcd_number[9:8]}),
        .sev_seg(sev_seg_0)
    );
    binary_to_sg b2sg_1 (
        .binary_in(bcd_number[7:4]),
        .sev_seg(sev_seg_1)
    );
    binary_to_sg b2sg_2 (
        .binary_in(bcd_number[3:0]),
        .sev_seg(sev_seg_2)
    );


    seven_seg_drawer #(
        .X_OFFSET(4)
    ) drawer_0 (
        .x(x),
        .y(y),
        .is_displaying_pixels(is_displaying_pixels),
        .sev_seg(sev_seg_0),
        .io_rgb_color(io_rgb_color_0)
    );

    seven_seg_drawer #(
        .X_OFFSET(60)
    ) drawer_1 (
        .x(x),
        .y(y),
        .is_displaying_pixels(is_displaying_pixels),
        .sev_seg(sev_seg_1),
        .io_rgb_color(io_rgb_color_1)
    );

    seven_seg_drawer #(
        .X_OFFSET(116)
    ) drawer_2 (
        .x(x),
        .y(y),
        .is_displaying_pixels(is_displaying_pixels),
        .sev_seg(sev_seg_2),
        .io_rgb_color(io_rgb_color_2)
    );


    assign io_rgb_color = (io_rgb_color_0 | io_rgb_color_1 | io_rgb_color_2);
    
endmodule