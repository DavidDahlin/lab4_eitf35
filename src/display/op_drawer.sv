`timescale 1ns / 1ps

module op_drawer #(
    parameter int X_OFFSET = 4
) (
    // control signals
    input logic is_displaying_pixels,
    input logic[10:0] x,
    input logic[10:0] y,

    // data lines
    input logic overflow,
    input logic[7:0] op,
    output logic[11:0] io_rgb_color
);

    localparam Y_OFFSET = 160;
    localparam COLOR_WHITE = 12'hfff;
    localparam COLOR_RED = 12'h00f;
    localparam NUM_HORIZONTAL_VISIBLE_PIXELS = 640;
    localparam NUM_VERTICAL_VISIBLE_LINES = 480;

    // "-" --> 1 -> 130
    // "+" --> 2 -> 131
    // "*" --> 3 -> 132
    // "%" --> 4 -> 133

    always_comb begin : NUMBER_DRIVER

        io_rgb_color = 12'h000;

        if (is_displaying_pixels) begin
            if(op == 8'd130 || op == 8'd131 || op == 8'd133) begin
                if((x > (18 + X_OFFSET) && x <= (38 + X_OFFSET)) && (y > (77 + Y_OFFSET) && y <= (82 + Y_OFFSET))) begin
                    io_rgb_color = COLOR_WHITE;
                end
            end
            if(op == 8'd131) begin
                if((x > (26 + X_OFFSET) && x <= (30 + X_OFFSET)) && (y > (70 + Y_OFFSET) && y <= (90 + Y_OFFSET))) begin
                    io_rgb_color = COLOR_WHITE;
                end
            end
            if(op == 8'd132) begin
                if((x > (26 + X_OFFSET) && x <= (30 + X_OFFSET)) && (y > (78 + Y_OFFSET) && y <= (82 + Y_OFFSET))) begin
                    io_rgb_color = COLOR_WHITE;
                end
            end
            if(op == 8'd133) begin
                if((x > (33 + X_OFFSET) && x <= (38 + X_OFFSET)) && (y > (85 + Y_OFFSET) && y <= (90 + Y_OFFSET)) || (x > (18 + X_OFFSET) && x <= (23 + X_OFFSET)) && (y > (70 + Y_OFFSET) && y <= (75 + Y_OFFSET))) begin
                    io_rgb_color = COLOR_WHITE;
                end
            end
            if(overflow == 1) begin
                if((x > (26 + X_OFFSET) && x <= (30 + X_OFFSET)) && (y > (60 + Y_OFFSET) && y <= (65 + Y_OFFSET))) begin
                    io_rgb_color = COLOR_RED;
                end
            end
        end
    end

endmodule