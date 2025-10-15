`timescale 1ns/1ps

module seven_seg_driver (
    input logic clk,
    input logic rst,
    input logic [9:0] bcd_digit,
    input logic sign,
    input logic overflow,
    output logic [3:0] digit_anode,
    output logic [7:0] segment
    );

    // local
    logic [3:0] sign_in;

    // input buffer
    logic [9:0] in_buffer, in_buffer_next;

    // for mux register
    logic [7:0] digit_0, digit_0_next;
    logic [7:0] digit_1, digit_1_next;
    logic [7:0] digit_2, digit_2_next;
    logic [7:0] digit_3, digit_3_next;

    // counter mux
    logic [15:0] delay_counter, delay_counter_next;
    logic [1:0] display_counter, display_counter_next;

    always_ff @(posedge clk or negedge rst) begin : input_buffer_register
        if(rst == 0) begin
            in_buffer <= '0;
        end else begin
            in_buffer <= in_buffer_next;
        end
    end

    assign in_buffer_next = bcd_digit;

    always_comb begin : convert_to_digits
        // default
        sign_in = 4'h0;
        if(overflow == 1) begin
            sign_in = 4'hE;
        end else if (sign == 1) begin
            sign_in = 4'hA;
        end
    end

    binary_to_sg binary_to_sg_inst_0 (
        .binary_in(sign_in),
        .sev_seg(digit_3_next)
    );
    binary_to_sg binary_to_sg_inst_1 (
        .binary_in({2'b00,in_buffer[9:8]}),
        .sev_seg(digit_2_next)
    );
    binary_to_sg binary_to_sg_inst_2 (
        .binary_in(in_buffer[7:4]),
        .sev_seg(digit_1_next)
    );
    binary_to_sg binary_to_sg_inst_3 (
        .binary_in(in_buffer[3:0]),
        .sev_seg(digit_0_next)
    );

    always_ff @(posedge clk or negedge rst) begin : mux_register
        if(rst == 0) begin
            digit_0 <= '0;
            digit_1 <= '0;
            digit_2 <= '0;
            digit_3 <= '0;
        end else begin
            digit_0 <= digit_0_next;
            digit_1 <= digit_1_next;
            digit_2 <= digit_2_next;
            digit_3 <= digit_3_next;
        end
    end

    always_ff @(posedge clk or negedge rst) begin : counters
        if(rst == 0) begin
            delay_counter <= '0;
            display_counter <= '0;
        end else begin
            delay_counter <= delay_counter_next;
            display_counter <= display_counter_next;
        end
    end

    assign delay_counter_next = delay_counter + 1;
    assign display_counter_next = (delay_counter == 16'hFFFF) ? display_counter + 1 : display_counter;

    always_comb begin : muxing
        case(display_counter)
            2'd0 : segment = digit_0;
            2'd1 : segment = digit_1;
            2'd2 : segment = digit_2;
            2'd3 : segment = digit_3;
        endcase
    end

    assign digit_anode = ~(4'b0001 << display_counter);
    
endmodule 
