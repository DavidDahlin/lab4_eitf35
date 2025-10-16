// TITLE: keyboard_ctrl.sv
// PROJECT: Keyboard VLSI lab
// DESCRIPTION: Controller to handle the scan codes

`timescale 1ns/1ps

module keyboard_ctrl (
    input logic clk,
    input logic rst,
    input logic valid_code,
    input logic [7:0] scan_code_in,
    output logic [7:0] code_to_display,
    output logic [3:0] seg_en,

    // debug
    output logic [7:0] l_sc
    );

    assign l_sc = latest_scan_code_in;

    logic [15:0] delay_counter; 
    logic [15:0] delay_counter_next; 

    logic [1:0] display_counter;
    logic [1:0] display_counter_next;

    logic [7:0] latest_scan_code_in;
    logic [7:0] latest_scan_code_in_next;

    logic [31:0] register_of_digits;
    logic [31:0] register_of_digits_next;


    always_ff @(posedge clk or negedge rst) begin
        if(rst == 0)begin
            delay_counter <= '0;
            display_counter <= '0;
        end else begin
            delay_counter <= delay_counter_next;
            display_counter <= display_counter_next;
        end
    end

    always_ff @(posedge clk or negedge rst) begin //For registers 
        if(rst == 0)begin
            latest_scan_code_in <= '0;
            register_of_digits <= '0;
        end else begin
            latest_scan_code_in <= latest_scan_code_in_next;
            register_of_digits <= register_of_digits_next;
        end
    end

    assign delay_counter_next = delay_counter + 1; //Delay counter block

    always_comb begin : display_counter_block
        display_counter_next = display_counter;
        if(delay_counter == '0) display_counter_next = display_counter + 1;
    end


    always_comb begin : latest_scan_code_in_block
        latest_scan_code_in_next = latest_scan_code_in;
        if(valid_code == 1) latest_scan_code_in_next = scan_code_in;
    end

    always_comb begin : register_to_display_block
        register_of_digits_next = register_of_digits;
        if(valid_code == 1 && latest_scan_code_in == 8'hF0) register_of_digits_next = {register_of_digits[23:0], scan_code_in};
    end


    always_comb begin
        case (display_counter)
            2'd0: code_to_display = register_of_digits[7:0];
            2'd1: code_to_display = register_of_digits[15:8]; 
            2'd2: code_to_display = register_of_digits[23:16]; 
            2'd3: code_to_display = register_of_digits[31:24]; 

            default: begin
                code_to_display  = 8'h00;
            end
        endcase
        
    end
    

    assign seg_en = ~(4'b0001 << display_counter); //seg_en output

endmodule