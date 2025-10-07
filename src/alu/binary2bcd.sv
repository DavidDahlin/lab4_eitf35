`timescale 1ns/1ps

module binary2bcd (
    input logic [7:0] binary_in,
    output logic [9:0] bcd_out
);

logic [17:0] init, step_1, step_2, step_3, step_4, step_5, step_6, step_7, step_8, step_9, step_10, step_11;

always_comb begin
    init = {10'd0, binary_in};
    step_1 = init << 3; 

    if(step_1[11:8] > 4'd4) step_2 = {step_1[17:12] ,step_1[11:8] + 4'd3, step_1[7:0]};
    else step_2 = step_1;


    step_3 = step_2 << 1;

    if(step_3[11:8] > 4'd4) step_4 = {step_3[17:12] ,step_3[11:8] + 4'd3, step_3[7:0]};
    else step_4 = step_3;

    step_5 = step_4 << 1;

    if(step_5[11:8] > 4'd4) step_6 = {step_5[17:12] ,step_5[11:8] + 4'd3, step_5[7:0]};
    else step_6 = step_5;    

    step_7 = step_6 << 1;

    if(step_7[15:12] > 4'd4 && step_7[11:8] > 4'd4 ) step_8 = {step_7[17:16], step_7[15:12] + 4'd3, step_7[11:8] + 4'd3, step_7[7:0]};
    else if(step_7[15:12] > 4'd4 ) step_8 = {step_7[17:16], step_7[15:12] + 4'd3, step_7[11:0]};
    else if(step_7[11:8] > 4'd4 ) step_8 = {step_7[17:12], step_7[11:8] + 4'd3, step_7[7:0]};
    else step_8 = step_7;

    step_9 = step_8 << 1; 

    if(step_9[15:12] > 4'd4 && step_9[11:8] > 4'd4 ) step_10 = {step_9[17:16], step_9[15:12] + 4'd3, step_9[11:8] + 4'd3, step_9[7:0]};
    else if(step_9[15:12] > 4'd4 ) step_10 = {step_9[17:16], step_9[15:12] + 4'd3, step_9[11:0]};
    else if(step_9[11:8] > 4'd4 ) step_10 = {step_9[17:12], step_9[11:8] + 4'd3, step_9[7:0]};
    else step_10 = step_9;

    step_11 = step_10 << 1;
end

    assign bcd_out = step_11[17:8];
    

endmodule
