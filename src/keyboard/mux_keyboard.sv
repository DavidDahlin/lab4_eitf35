// TITLE: mux_keyboard.sv
// PROJECT: Lab 4
// DESCRIPTION: mux depending on counter from op_ctrl

`timescale 1ns/1ps

module mux_keyboard(
    input logic clk,
    input logic rst,

    input logic op_ctrl,
    input logic [7:0] number,
    input logic [3:0] operand,

    output logic valid,
    output logic [7:0] num_or_operand
);

logic [1:0] counter;
logic [1:0] counter_next;


logic [7:0] out_reg;
logic [7:0] out_reg_next;

logic val_reg; 
logic val_reg_next; 

logic op; //For timing
logic op_next; 

assign op_next = op_ctrl;
always_ff @(posedge clk or negedge rst) begin
    if(rst == 0) op <= '0;
    else op <= op_next;
end






always_ff @(posedge clk or negedge rst) begin
    if(rst == 0) begin
        counter <= '0;
        val_reg <= '0;
        out_reg <= '0;

    end else begin
        counter <= counter_next;
        val_reg <= val_reg_next;
        out_reg <= out_reg_next;
    end
end

//counter
always_comb begin
    counter_next = counter;
    if(op)begin 
        if(operand == 4'hd) counter_next = 2'd0;
        else counter_next = (counter == 2'd2) ? 2'd0 : counter + 1; 
    end
end


always_comb begin
    out_reg_next = out_reg;
    case (counter)
        2'd1: begin
            out_reg_next = {4'd0, operand} + 8'd120;
        end
        default: begin
            out_reg_next = number;
        end
    endcase
end

assign val_reg_next = (op) ? 1 : 0;

assign valid = val_reg;
assign num_or_operand = out_reg;

endmodule