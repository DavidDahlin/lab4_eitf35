`timescale 1ns / 1ps


module vga_driver_top(
    // top level signals
    input logic clk,
    input logic reset_n,

    // Display inputs
    input logic[7:0] a,
    input logic[7:0] b,
    input logic[7:0] result,
    input logic[3:0] operand,

    // Control signals
    input logic valid,

    // Outputs
    output logic[11:0] io_rgb_color,
    output logic io_horizontal_sync,
    output logic io_vertical_sync

); 


    vga vga_controller(
        .clock(clk),
        .reset_n(reset_n),
        .io_horizontal_sync(io_horizontal_sync),
        .io_vertical_sync(io_vertical_sync),
        .io_rgb_color(io_rgb_color),
    )

    
endmodule