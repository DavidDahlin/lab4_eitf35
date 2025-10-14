`timescale 1ns / 1ps

module seven_seg_drawer #(
    parameter int X_OFFSET = 4
) (
    // control signals
    input logic is_displaying_pixels,
    input logic[10:0] x,
    input logic[10:0] y,

    // data lines
    input logic[7:0] sev_seg,
    output logic[11:0] io_rgb_color
);

    localparam Y_OFFSET = 160;
    localparam COLOR_RED = 12'h00f;
    localparam NUM_HORIZONTAL_VISIBLE_PIXELS = 640;
    localparam NUM_VERTICAL_VISIBLE_LINES = 480;

    always_comb begin : NUMBER_DRIVER

        io_rgb_color = 12'h000;

        if (is_displaying_pixels) begin
                if(sev_seg[7] == 0) begin // dot
                    if((x > (47 + X_OFFSET) && x <= (52 + X_OFFSET)) && (y > (106 + Y_OFFSET) && y <= (111 + Y_OFFSET))) begin
                        io_rgb_color = COLOR_RED;
                    end
                end
                if(sev_seg[6] == 0) begin // g
                    if((x > (18 + X_OFFSET) && x <= (38 + X_OFFSET)) && (y > (77 + Y_OFFSET) && y <= (82 + Y_OFFSET))) begin
                        io_rgb_color = COLOR_RED;
                    end
                end
                if(sev_seg[5] == 0) begin // f
                    if((x > (11 + X_OFFSET) && x <= (16 + X_OFFSET)) && (y > (55 + Y_OFFSET) && y <= (75 + Y_OFFSET))) begin
                        io_rgb_color = COLOR_RED;
                    end
                end
                if(sev_seg[4] == 0) begin // e
                    if((x > (11 + X_OFFSET) && x <= (16 + X_OFFSET)) && (y > (84 + Y_OFFSET) && y <= (104 + Y_OFFSET))) begin
                        io_rgb_color = COLOR_RED;
                    end
                end
                if(sev_seg[3] == 0) begin // d
                    if((x > (18 + X_OFFSET) && x <= (38 + X_OFFSET)) && (y > (106 + Y_OFFSET) && y <= (111 + Y_OFFSET))) begin
                        io_rgb_color = COLOR_RED;
                    end
                end
                if(sev_seg[2] == 0) begin // c
                    if((x > (40 + X_OFFSET) && x <= (45 + X_OFFSET)) && (y > (84 + Y_OFFSET) && y <= (104 + Y_OFFSET))) begin
                        io_rgb_color = COLOR_RED;
                    end
                end
                if(sev_seg[1] == 0) begin // b
                    if((x > (40 + X_OFFSET) && x <= (45 + X_OFFSET)) && (y > (55 + Y_OFFSET) && y <= (75 + Y_OFFSET))) begin
                        io_rgb_color = COLOR_RED;
                    end
                end
                if(sev_seg[0] == 0) begin // a
                    if((x > (18 + X_OFFSET) && x <= (38 + X_OFFSET)) && (y > (48 + Y_OFFSET) && y <= (53 + Y_OFFSET))) begin
                        io_rgb_color = COLOR_RED;
                    end
                end
        end
    end


    
endmodule