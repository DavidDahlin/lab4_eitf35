`timescale 1ns/1ps

module calulator_top(
    input logic clk,
    input logic rst,

    // Data Latching (BTNC)
    input logic latch,

    // Keyboard inputs
    input logic kb_data,
    input logic kb_clk,

    // Keyboard Debug
    output logic [7:0] scan_code,

    // VGA
    output logic[11:0] io_rgb_color
);

    logic [7:0] op, a, b, result;
    logic sign, overflow;

    alu_top alu (
        .a(a),
        .b(b),
        .op(op),
        .result(result),
        .overflow(overflow),
        .sign(sign)
    );

    display_top vga_driver (
        .clk(clk),
        .rst(rst),
        .a(a),
        .b(b),
        .result(result),
        .sign(sign),
        .overflow(overflow),
        .operand(op),
        .valid(TODO), // enter
        .io_rgb_color(io_rgb_color),
        .io_horizontal_sync(io_horizontal_sync),
        .io_vertical_sync(io_vertical_sync)
    );

    


endmodule