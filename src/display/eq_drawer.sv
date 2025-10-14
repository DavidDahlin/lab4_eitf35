`timescale 1ns / 1ps

module eq_drawer #(
    parameter int X_OFFSET = 4
) (
    // control signals
    input logic is_displaying_pixels,
    input logic[10:0] x,
    input logic[10:0] y,
    
    output logic[11:0] io_rgb_color
);

    localparam Y_OFFSET = 160;
    localparam COLOR_BLUE = 12'h0f0;
    localparam NUM_HORIZONTAL_VISIBLE_PIXELS = 640;
    localparam NUM_VERTICAL_VISIBLE_LINES = 480;

    always_comb begin : NUMBER_DRIVER

        io_rgb_color = 12'h000;

        if (is_displaying_pixels) begin
            if((x > (18 + X_OFFSET) && x <= (38 + X_OFFSET)) && ((y > (72 + Y_OFFSET) && y <= (77 + Y_OFFSET)) || (y > (83 + Y_OFFSET) && y <= (88 + Y_OFFSET)))) begin
                io_rgb_color = COLOR_BLUE;
            end
        end
    end


    
endmodule