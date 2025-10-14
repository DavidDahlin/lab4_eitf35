`timescale 1ns / 1ps

module op_drawer #(
    parameter int X_OFFSET = 4
) (
    // control signals
    input logic is_displaying_pixels,
    input logic[10:0] x,
    input logic[10:0] y,

    // data lines
    input logic[7:0] op,
    output logic[11:0] io_rgb_color
);

    localparam Y_OFFSET = 160;
    localparam COLOR_WHITE = 12'hfff;
    localparam NUM_HORIZONTAL_VISIBLE_PIXELS = 640;
    localparam NUM_VERTICAL_VISIBLE_LINES = 480;

    always_comb begin : NUMBER_DRIVER

        io_rgb_color = 12'h000;

        if (is_displaying_pixels) begin
            if(op == 8'h0A || op == 8'h0b || op == 8'h0d) begin
                if((x > (18 + X_OFFSET) && x <= (38 + X_OFFSET)) && (y > (77 + Y_OFFSET) && y <= (82 + Y_OFFSET))) begin
                    io_rgb_color = COLOR_WHITE;
                end
            end
            if(op == 8'h0b) begin
                if((x > (26 + X_OFFSET) && x <= (30 + X_OFFSET)) && (y > (70 + Y_OFFSET) && y <= (90 + Y_OFFSET))) begin
                    io_rgb_color = COLOR_WHITE;
                end
            end
            if(op == 8'h0c) begin
                if((x > (26 + X_OFFSET) && x <= (30 + X_OFFSET)) && (y > (78 + Y_OFFSET) && y <= (82 + Y_OFFSET))) begin
                    io_rgb_color = COLOR_WHITE;
                end
            end
            if(op == 8'h0d) begin
                if((x > (33 + X_OFFSET) && x <= (38 + X_OFFSET)) && (y > (85 + Y_OFFSET) && y <= (90 + Y_OFFSET)) || (x > (18 + X_OFFSET) && x <= (23 + X_OFFSET)) && (y > (70 + Y_OFFSET) && y <= (75 + Y_OFFSET))) begin
                    io_rgb_color = COLOR_WHITE;
                end
            end
        end
    end


    
endmodule


// 8'h4A:  binary_out = 4'h0a; //"-" --> 1
// 8'h4E:  binary_out = 4'h0b; //"+" --> 2
// 8'h5D:  binary_out = 4'h0c; //"*" --> 3
// 8'h2E:  binary_out = 4'h0d; //"%" --> 4