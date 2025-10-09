// TITLE demux_keyboard_bin_codes.sv
// PROJECT: Keyboard module
// DESCRIPTION: 3 diffrent outputs depending in the inputs

`timescale 1ns/1ps

module demux_keyboard(
    input logic [3:0] binary_val,
    output logic[3:0] number, 
    output logic[3:0] operand,
    output logic enter_signal, 
);

always_comb begin
    number = '0;
    operand = '0;
    enter_signal = '0;
    if(binary_val < 4'd10) number = binary_val;
    else if (binary_val < 4'd14) operand = binary_val;
    else if (binary_val == 4'd14) operand = 1'b1;
end
    
endmodule
