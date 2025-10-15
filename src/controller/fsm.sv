`timescale 1ns/1ps

import alu_common::*;

module fsm(
    // Control signals
    input logic latch_data,
    input logic valid_keyboard_input,

    // Memory logic
    output logic pop,
    output logic push,

    // ALU CONTROL SINGALS
    input logic [7:0] operand,

    // DATA IO
    input logic [7:0] keyboard_input,
    output logic [7:0] memory_write
);

    typedef enum {s_WAIT, s_POP, s_PUSH} state; 
    
    

    
endmodule