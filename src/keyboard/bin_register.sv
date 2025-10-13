// TITLE: bin_register.sv
// PROJECT: Lab 4
// DESCRIPTION: Registers the bcd value

`timescale 1ns/1ps

module convert_to_binary ( 
    input logic clk,
    input logic rst,
    input logic op_ctrl,
    input logic [3:0] binary_val,
    input logic valid_scan_code,
    output logic [11:0] bcd_value
);


logic [11:0] shift_reg;
logic [11:0] shift_reg_next;


always_ff @(posedge clk or negedge rst) begin
    if(rst == 0) begin
        shift_reg <= '0;
    end else begin
        shift_reg <= shift_reg_next;
    end
end

always_comb begin
    shift_reg_next = shift_reg;
    if (op_ctrl) shift_reg_next = '0;
    else if (valid_scan_code) shift_reg_next = {shift_reg[7:0], binary_val};
end

assign bcd_value = shift_reg;


endmodule