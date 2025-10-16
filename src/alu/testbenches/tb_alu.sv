`timescale 1ns / 1ps

module testbench_alu();

    logic [7:0] a, b, op, result;
    logic overflow, sign;

    initial begin
        a = 10;
        b = 15;
        op = 131;
        #100;
        a = 15;
        b = 5;
        op = 130;
        #100;
        a = 2;
        b = 3;
        op = 132;
        #100;
        a = 30;
        b = 50;
        op = 132;
        #100;
        a = 120;
        b = 10;
        op = 133;
        #100;
        a = 90;
        b = 100;
        op = 130;
    end

    alu alu_inst(
        .a(a),
        .b(b),
        .op(op),
        .result(result),
        .overflow(overflow),
        .sign(sign)
    );


endmodule
