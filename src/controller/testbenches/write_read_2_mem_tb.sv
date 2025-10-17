`timescale 1ns/1ps


module w_n_r_2mem_tb ();

    logic clk;
    logic rst;

    input logic enter_edge,
    input logic valid_signal,
    input logic [7:0] value,

    input [7:0] douta,

    output logic wea,
    output logic ena,
    output logic [12:0] addra,
    output logic [7:0] dina, 
    

    output logic [7:0] a, b, op




    w_n_r_2mem dut (
        .clk(clk),
        .rst(rst),
        .enter_edge(enter_edge),
        .valid_signal(valid_signal),
        .value(value),
        .douta(data),
        .ena(ena),
        .wna(wea),
        .addra(addra),
        .dina(dina)
        .a(a),
        .b(b),
        .op(op)
    );




endmodule