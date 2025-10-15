`timescale 1ns / 1ps


module display_test (
    // top level signals
    input logic clk,
    input logic rst,

    // Display inputs
    input logic[7:0] number,
    // input logic[7:0] b,
    // input logic[7:0] result,
    // input logic[7:0] operand,
    // input logic sign,

    // Control signals
    // input logic valid,

    // Outputs
    output logic[11:0] io_rgb_color,
    output logic io_horizontal_sync,
    output logic io_vertical_sync

); 

    display_top display(
        .a(number),
        .b(8'd143),
        .result(8'd132),
        .operand(8'd133),
        .io_rgb_color(io_rgb_color),
        .clk(clk),
        .rst(rst),
        .sign(1'b0),
        .io_horizontal_sync(io_horizontal_sync),
        .io_vertical_sync(io_vertical_sync)
    );

endmodule