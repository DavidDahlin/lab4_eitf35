// TITLE: bin_register.sv
// PROJECT: Lab 4
// DESCRIPTION: Registers the bcd value

`timescale 1ns/1ps

module bcd_register ( 
    input logic clk,
    input logic rst,
    input logic op_ctrl,
    input logic [3:0] binary_val,
    input logic valid_scan_code,

    output logic [9:0] bcd_value
);


logic [15:0] shift_reg;
logic [15:0] shift_reg_next;


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
    else if (valid_scan_code) begin
        shift_reg_next = (binary_val == 4'he) ? shift_reg >> 4 : {shift_reg[11:0], binary_val};
    end
end


assign bcd_value = (shift_reg[15:12] > 4'd0 || shift_reg[11:0] > 10'h255 ) ? 10'h255 : shift_reg[9:0];


endmodule