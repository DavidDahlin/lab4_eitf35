// TITLE: bin_register.sv
// PROJECT: Lab 4
// DESCRIPTION: reverse doubble dabble

`timescale 1ns/1ps

module bcd2bin (
    input logic [9:0] bcd,
    output logic [7:0] bin
);

logic [17:0] init, step_1, step_2, step_3, step_4, step_5, step_6, step_7, step_8, step_9, step_10, step_11, step_12, step_13 ;


always_comb begin
    init = {bcd, 8'd0};

    step_1 = init >> 1; //1

    step_2[17:12] =(step_1[15:12] >= 4'd8) ? {step_1[17:16],step_1[15:12]-4'd3} : {step_1[17:16] ,step_1[15:12]};
    step_2[11:0] =(step_1[11:8] >= 4'd8) ?{ step_1[11:8]-4'd3, step_1[7:0]} : {step_1[11:8], step_1[7:0]};
    
    step_3 = step_2 >> 1; //2

    step_4[17:12] =(step_3[15:12] >= 4'd8) ? {step_3[17:16],step_3[15:12]-4'd3} : {step_3[17:16] ,step_3[15:12]};
    step_4[11:0] =(step_3[11:8] >= 4'd8) ?{ step_3[11:8]-4'd3, step_3[7:0]} : {step_3[11:8], step_3[7:0]};
    
    step_5 = step_4 >> 1;//3


    step_6 = (step_5[11:8] >= 4'd8) ?{step_5[17:12] ,step_5[11:8]-4'd3, step_5[7:0]} : step_5;

    step_7 = step_6 >>1;//4

    step_8 = (step_7[11:8] >= 4'd8) ?{step_7[17:12] ,step_7[11:8]-4'd3, step_7[7:0]} : step_7;

    step_9 = step_8 >> 1; //5

    step_10 = (step_9[11:8] >= 4'd8) ?{step_9[17:12] ,step_9[11:8]-4'd3, step_9[7:0]} : step_9;

    step_11 = step_10 >> 1; //6

    step_12 = (step_11[11:8] >= 4'd8) ?{step_11[17:12] ,step_11[11:8]-4'd3, step_11[7:0]} : step_11;

    bin = step_12[9:2];

end

endmodule


