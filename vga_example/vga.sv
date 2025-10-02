`timescale 1ns / 1ps


module vga(
    input logic clock,
    input logic reset_n,
    output logic io_horizontal_sync,
    output logic io_vertical_sync,
    output logic [11:0] io_rgb_color
);

    localparam COLOR_BLUE = 12'hf00;
    localparam COLOR_GREEN = 12'h0f0;
    localparam COLOR_RED = 12'h00f;
    localparam COLOR_WHITE = 12'hfff;
    
    localparam NUM_HORIZONTAL_VISIBLE_PIXELS = 640;
    localparam NUM_HORIZONTAL_FRONT_PORCH_PIXELS = 16;
    localparam NUM_HORIZONTAL_SYNC_PIXELS = 96;
    localparam NUM_HORIZONTAL_BACK_PORCH_PIXELS = 48;
    localparam NUM_HORIZONTAL_ALL_PIXELS = 
        NUM_HORIZONTAL_VISIBLE_PIXELS + NUM_HORIZONTAL_FRONT_PORCH_PIXELS + 
        NUM_HORIZONTAL_SYNC_PIXELS + NUM_HORIZONTAL_BACK_PORCH_PIXELS;
    
    localparam NUM_VERTICAL_VISIBLE_LINES = 480;
    localparam NUM_VERTICAL_FRONT_PORCH_LINES = 10;
    localparam NUM_VERTICAL_SYNC_LINES = 2;
    localparam NUM_VERTICAL_BACK_PORCH_LINES = 29;
    localparam NUM_VERTICAL_ALL_LINES = 
        NUM_VERTICAL_VISIBLE_LINES + NUM_VERTICAL_FRONT_PORCH_LINES + 
        NUM_VERTICAL_SYNC_LINES + NUM_VERTICAL_BACK_PORCH_LINES;

    logic [10:0] horizontal_counter_reg, horizontal_counter_next;
    logic [10:0] vertical_counter_reg, vertical_counter_next;
    
    logic [1:0] counter_25mhz_next;
    logic [1:0] counter_25mhz_reg;
    logic clock_25mhz = counter_25mhz_reg == 3;

    logic h_sync_reg, h_sync_next;
    logic v_sync_reg, v_sync_next;

    logic is_displaying_pixels;
    
    
    always_ff @ (posedge clock)
    begin
        if (reset_n == 0) begin
            horizontal_counter_reg <= 0;
            vertical_counter_reg <= 0;
            h_sync_reg <= 1;
            v_sync_reg <= 1;     
            counter_25mhz_reg <= 0;
        end 
        else begin
            horizontal_counter_reg <= horizontal_counter_next;
            vertical_counter_reg <= vertical_counter_next;
            h_sync_reg <= h_sync_next;
            v_sync_reg <= v_sync_next;     
            counter_25mhz_reg <= counter_25mhz_next;
        end
    end
    
    
    assign counter_25mhz_next = counter_25mhz_reg + 1;
    

    always_comb
    begin
        horizontal_counter_next = horizontal_counter_reg;
        vertical_counter_next = vertical_counter_reg;            
        
        if (clock_25mhz) begin
            if (horizontal_counter_reg == NUM_HORIZONTAL_ALL_PIXELS-1) begin
                horizontal_counter_next = 0;
            end
            else begin
                horizontal_counter_next = horizontal_counter_reg + 1;
            end
            
            if (horizontal_counter_reg == NUM_HORIZONTAL_ALL_PIXELS-1) begin
                vertical_counter_next = vertical_counter_reg + 1;
                if (vertical_counter_reg == NUM_VERTICAL_ALL_LINES-1) begin
                    vertical_counter_next = 0;
                end
            end
        end
    end
    
    
    always_comb
    begin
        h_sync_next = h_sync_reg;
        v_sync_next = v_sync_reg;      
        
        if (clock_25mhz) begin            
            if (
                horizontal_counter_reg >= NUM_HORIZONTAL_VISIBLE_PIXELS + NUM_HORIZONTAL_FRONT_PORCH_PIXELS &&
                horizontal_counter_reg < NUM_HORIZONTAL_VISIBLE_PIXELS + NUM_HORIZONTAL_FRONT_PORCH_PIXELS + NUM_HORIZONTAL_SYNC_PIXELS
            ) begin
                h_sync_next = 0;
            end
            else begin
                h_sync_next = 1;
            end
            
            if (
                vertical_counter_reg >= NUM_VERTICAL_VISIBLE_LINES + NUM_VERTICAL_FRONT_PORCH_LINES &&
                vertical_counter_reg < NUM_VERTICAL_VISIBLE_LINES + NUM_VERTICAL_FRONT_PORCH_LINES + NUM_VERTICAL_SYNC_LINES
            ) begin
                v_sync_next = 0;
            end
            else begin
                v_sync_next = 1;
            end                              
        end                      
    end
        
        
    always_comb
    begin
        is_displaying_pixels = 0;              
        if (horizontal_counter_reg < NUM_HORIZONTAL_VISIBLE_PIXELS && vertical_counter_reg < NUM_VERTICAL_VISIBLE_LINES) begin
            is_displaying_pixels = 1;
        end                          
    end
    
    
    // Draw pixels on the screen
    always_comb
    begin
        io_rgb_color = 0;
        if (is_displaying_pixels) begin
            // Paint the middle pixel in the 3rd row white
            if (vertical_counter_reg == 3-1 && horizontal_counter_reg == NUM_HORIZONTAL_VISIBLE_PIXELS/2) begin
                io_rgb_color = COLOR_WHITE;
            end                   
            
            // Draw red, green, and blue squares in the middle of the screen
            if (vertical_counter_reg >= NUM_VERTICAL_VISIBLE_LINES/3 && vertical_counter_reg < 2*NUM_VERTICAL_VISIBLE_LINES/3) begin
                if (horizontal_counter_reg < NUM_HORIZONTAL_VISIBLE_PIXELS/3) begin
                    io_rgb_color = COLOR_RED;
                end
                else if (horizontal_counter_reg < 2*NUM_HORIZONTAL_VISIBLE_PIXELS/3) begin
                    io_rgb_color = COLOR_BLUE;
                end
                else begin
                    io_rgb_color = COLOR_GREEN;
                end
            end
        end                              
    end
        
    assign io_horizontal_sync = h_sync_reg;
    assign io_vertical_sync = v_sync_reg;     
          
endmodule
