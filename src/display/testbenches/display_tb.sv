`timescale 1ns / 1ps

module testbench_display();


    logic clk = 1;
    logic reset_n;
    logic [7:0] number;
    logic io_horizontal_sync;
    logic io_vertical_sync;
    logic[11:0] io_rgb_color;

    always #10 clk = ~clk;


    initial begin
        reset_n = 0;
        @clk;
        @clk;
        reset_n = 1;
        @clk;
        number = 8'd135;
        @clk;
        number = 8'd200;

    end

    display_top disp (
        .clk(clock),
        .reset_n(reset_n),
        .number(number),
        .io_rgb_color(io_rgb_color),
        .io_horizontal_sync(io_horizontal_sync),
        .io_vertical_sync(io_vertical_sync)
    );


endmodule
