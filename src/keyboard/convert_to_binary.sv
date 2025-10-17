// TITLE: convert_to_binary.sv
// PROJECT: Keyboard VLSI lab
// DESCRIPTION: Look-up-table SEPARATE SIGNAL FOR ENTER!

`timescale 1ns/1ps

module convert_to_binary (
    input logic [7:0] scan_code_in,
    output logic [3:0] binary_out,
    output logic enter_signal
    );
    // Simple combinational logic using case statements (LUT)

    always_comb begin
        case (scan_code_in)
            8'h16:  binary_out = 4'd1;
            8'h1E:  binary_out = 4'd2;
            8'h26:  binary_out = 4'd3;
            8'h25:  binary_out = 4'd4;
            8'h2E:  binary_out = 4'd5;
            8'h36:  binary_out = 4'd6;
            8'h3D:  binary_out = 4'd7;
            8'h3E:  binary_out = 4'd8;
            8'h46:  binary_out = 4'd9;
            8'h45:  binary_out = 4'd0;


            8'h4A:  binary_out = 4'ha; //"-" 
            8'h4E:  binary_out = 4'hb; //"+" 
            8'h5D:  binary_out = 4'hc; //"*" 
            8'h3A:  binary_out = 4'hd; //"%" 

            8'h66:  binary_out = 4'he; //"backspace"


            8'h00:  binary_out = 4'hF; // EMPTY
            // 8'hFF:  binary_out = 4'hE; // ERROR -- Don't remember why this one existed
            default:  binary_out = 4'hF; //ERROR --> Empty
        endcase
    end

    assign enter_signal = (scan_code_in == 8'h5A) ? 1 : 0;


endmodule