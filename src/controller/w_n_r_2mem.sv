`timescale 1ns/1ps


module w_n_r_2mem(
    input logic clk,
    input logic rst,

    input logic enter_edge,
    input logic valid_signal,
    input logic [7:0] value,

    input logic [7:0] douta,

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
assign modulo_flag = (pop_counter == 2'd2 && douta == 8'd133) ? 1 : 0; // For modulo




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
    else if(enter_or_valid == 2'b10 || pop_counter == 2'd1 || pop_counter == 2'd2 ) addr_counter_next = addr_counter - 1;
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
    else if(enter_or_valid == 2'b10) reader_next = 1;
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
    if (reader_ddd == 1) begin
        if(mod_flag_ddd == 1) internal_output_reg_next = {internal_output_reg[15:0], 8'h00};
        // else internal_output_reg_next = {internal_output_reg[15:0], douta};
        else internal_output_reg_next = {internal_output_reg[15:0], douta};

    end 
end /// ÄR READER HÖG FÖR KORT TID

logic reader_d, reader_d_n, reader_dd, reader_dd_n, mod_flag_d, mod_flag_d_n, mod_flag_dd, mod_flag_dd_n;
logic reader_ddd, reader_ddd_n, mod_flag_ddd, mod_flag_ddd_n;

always_ff @(posedge clk or negedge rst) begin
    if (rst==0) begin
        reader_d <= 0;
        reader_dd <= 0;
        reader_ddd <= 0;
        mod_flag_d <= 0;
        mod_flag_dd <= 0;
        mod_flag_ddd <= 0;
    end else begin
        reader_d <= reader_d_n;
        reader_dd <= reader_dd_n;
        reader_ddd <= reader_ddd_n;
        mod_flag_d <= mod_flag_d_n;
        mod_flag_dd <= mod_flag_dd_n;
        mod_flag_ddd <= mod_flag_ddd_n;
    end
end
always_comb begin
    reader_d_n = reader;
    reader_dd_n = reader_d;
    reader_ddd_n = reader_dd;
    mod_flag_d_n = modulo_flag;
    mod_flag_dd_n = mod_flag_d;
    mod_flag_ddd_n = mod_flag_dd;
end


always_comb begin
    internal_dina_next = internal_dina;
    if(enter_or_valid == 2'b01) internal_dina_next = value;
end


assign wea = writer;
assign addra = addr_counter;
assign ena = reader | writer;
assign dina = internal_dina;

// assign a = internal_output_reg[7:0];
// assign b = internal_output_reg[23:16];
// assign op = internal_output_reg[15:8];




logic [7:0] a_internal, a_internal_next, b_internal, b_internal_next, op_internal, op_internal_next;
logic [3:0] c, c_next;

always_ff @(posedge clk or negedge rst) begin
    if (rst == 0) begin
        c <= '0;
        a_internal <= '0;
        b_internal <= '0;
        op_internal <= '0;
    end else begin
        c <= c_next;
        a_internal <= a_internal_next;
        b_internal <= b_internal_next;
        op_internal <= op_internal_next;
    end
end

always_comb begin
    c_next = c;
    if(enter_edge == 1) begin
        c_next = 3'd1;
    end else if (c != 3'd0) begin
        c_next = c + 1;
    end
end

always_comb begin
    a_internal_next = a_internal;
    b_internal_next = b_internal;
    op_internal_next = op_internal;
    if(c == 3'd6) begin
        a_internal_next = internal_output_reg[7:0];
        b_internal_next = internal_output_reg[23:16];
        op_internal_next = internal_output_reg[15:8];
    end
end

assign a = a_internal;
assign b = b_internal;
assign op = op_internal;
    
endmodule