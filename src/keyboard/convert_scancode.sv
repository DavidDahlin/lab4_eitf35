// TITLE: convert_scancode.sv
// PROJECT: Keyboard VLSI lab
// DESCRIPTION: Implement a shift register to convert serial to parallel
// A counter to flag when the valid code is shifted in

`timescale 1ns/1ps

module convert_scancode (
    input logic clk,
    input logic rst,
    input logic edge_found,
    input logic serial_data,
    output logic valid_scan_code,
    output logic [7:0] scan_code_out
    );

    logic [9:0]  serial_data_register;
    logic [9:0]  serial_data_register_next;

    logic [3:0] counter;
    logic [3:0] counter_next;

    logic parity, parity_next;

    always_ff @(posedge clk or negedge rst) begin
        if(rst == 0)begin
            serial_data_register <= '0;
            counter <= '0;
            parity <= '0;
        end else begin
            serial_data_register <=  serial_data_register_next; 
            counter <= counter_next;
            parity <= parity_next;
        end
        
    end

    always_comb begin : seral_data_to_register_block
        serial_data_register_next =  serial_data_register;
        if(edge_found == 1) begin
            serial_data_register_next = {serial_data, serial_data_register[9:1]};
        end
    end

     always_comb begin : modulo_11_counter_block
        counter_next = counter; 
        if (edge_found == 1) begin
            counter_next = counter + 1;
        end 

        if (counter == 11) counter_next = 0;
    end

    always_comb begin : parity_checkx
        parity_next = parity;
        if (edge_found == 1) begin
            if (counter == 0) parity_next = serial_data;
            else parity_next = parity + serial_data;
        end
    end

    assign scan_code_out = serial_data_register[7:0];

    assign valid_scan_code = (counter == 11) & ~parity;
    
endmodule