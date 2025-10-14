// TITLE demux_keyboard_bin_codes.sv
// PROJECT: Keyboard module
// DESCRIPTION: 3 diffrent outputs depending in the inputs

`timescale 1ns/1ps

module demux_keyboard(
    input logic [3:0] binary_val,
    output logic[3:0] number, 
    output logic[3:0] operand,
    output logic backspace_signal 
);

always_comb begin
    number = 4'hff;
    operand = 4'h0;
    backspace_signal = 1'b0;
    if(binary_val < 4'd10) number = binary_val;
    else if (binary_val < 4'he) operand = binary_val;
    else if (binary_val == 4'he) backspace_signal = 1'b1;
end
    
endmodule
