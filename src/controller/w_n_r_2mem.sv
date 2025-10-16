`timescale 1ns/1ps


module w_n_r_2mem(
    input logic clk,
    input logic rst,

    input logic enter_edge,
    input logic valid_signal,
    input logic [7:0] value,

    input [7:0] douta,

    output logic wea,
    output logic ena,
    output logic [12:0] addra,
    output logic [7:0] dina, 
    

    output logic [7:0] a, b, op

);

logic [12:0] addr_counter;
logic [12:0] addr_counter_next;

logic [1:0] pop_counter;
logic [1:0] pop_counter_next;

logic writer;
logic writer_next;

logic reader;
logic reader_next;


logic [7:0] internal_dina;
logic [7:0] internal_dina_next;

logic [23:0] internal_output_reg;
logic [23:0] internal_output_reg_next;

logic modulo_flag;
assign modulo_flag = (pop_counter = 2'd2 && douta == 2'd133) ? 1 : 0; // For modulo




logic [1:0] enter_or_valid;

always_comb begin // For prioritys
    enter_or_valid = 2'b00;
    if (pop_counter == 2'd0) begin
        if (valid_signal == 1) enter_or_valid = 2'b01;
        else if (enter_edge == 1) enter_or_valid = 2'b10;
    end
end


always_ff @(posedge clk or negedge rst) begin
    if(rst == 0)begin
        addr_counter <= '0;
        pop_counter <= '0;
    end else begin
        addr_counter <= addr_counter_next;
        pop_counter <= pop_counter_next;
    end
end

always_comb begin
    pop_counter_next = pop_counter;
    if (modulo_flag == 1) pop_counter_next = 2'd0;
    else if (reader == 1 || enter_or_valid == 2'b10) pop_counter_next = pop_counter + 1;
end

always_comb begin
    addr_counter_next = addr_counter;

    if(writer == 1) addr_counter_next = addr_counter + 1;
    else if(reader == 1) addr_counter_next = addr_counter - 1;
end


always_ff @(posedge clk or negedge rst) begin
    if(rst == 0)begin
        writer <= '0;
        reader <= '0;
    end else begin
        writer <= writer_next;
        reader <= reader_next;
    end
end


assign writer_next = (enter_or_valid == 2'b01) ? 1'b1 : 1'b0;

always_comb begin
    reader_next = reader;
    if (pop_counter == 2'd3 || modulo_flag == 1) reader_next = 0;
    else if(enter_or_valid == 2'b01) reader_next = 1;
end





always_ff @(posedge clk or negedge rst) begin
    if(rst == 0)begin
        internal_output_reg <= '0;
        internal_dina <= '0;
    end else begin
        internal_output_reg <= internal_output_reg_next;
        internal_dina <= internal_dina_next;
    end
end

always_comb begin
    internal_output_reg_next = internal_output_reg;
    if (reader == 1) begin
        if(modulo_flag == 1) internal_output_reg_next = {internal_output_reg[15:0], 8'h00};
        else internal_output_reg_next = {internal_output_reg[15:0], douta};
    end 
end

always_comb begin
    internal_dina_next = internal_dina;
    if(enter_or_valid == 2'b01) internal_dina_next = value;
end


assign wea = reader;
assign addra = addr_counter;
assign ena = reader | writer;
assign dina = internal_dina;

assign {a, op, b} = internal_output_reg;

    
endmodule