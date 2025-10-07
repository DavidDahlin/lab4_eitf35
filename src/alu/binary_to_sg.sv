// TITLE: binary_to_sgd.sv
// PROJECT: Keyboard VLSI lab
// DESCRIPTION: Simple look-up table

`timescale 1ns/1ps

module binary_to_sg (
    input logic [3:0] binary_in,
    output logic [7:0] sev_seg
    );

    always_comb begin
        case (binary_in)
            4'd0:  sev_seg = 8'b11000000; // 0
            4'd1:  sev_seg = 8'b11111001; // 1
            4'd2:  sev_seg = 8'b10100100; // 2
            4'd3:  sev_seg = 8'b10110000; // 3
            4'd4:  sev_seg = 8'b10011001; // 4
            4'd5:  sev_seg = 8'b10010010; // 5
            4'd6:  sev_seg = 8'b10000010; // 6
            4'd7:  sev_seg = 8'b11111000; // 7
            4'd8:  sev_seg = 8'b10000000; // 8
            4'd9:  sev_seg = 8'b10010000; // 9
            4'hA:  sev_seg = 8'b10111111; // - sign
            4'hE:  sev_seg = 8'b10001110; // Overflow (F)
            default:  sev_seg = 8'b11111111; // Blank
        endcase
    end

endmodule
