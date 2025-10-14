`timescale 1ns/1ps


module mux_keyboard_testbench();
    
    logic clk = 0;
    logic rst = 0;
    logic op_ctrl = 0;


    logic[7:0] num, out;
    logic[3:0] op;

    logic valid;

    always #5 clk = ~clk;

    initial begin
        #10
        rst = 1;
        #10 

        num = 8'd10;
        #30
        op_ctrl = 1;
        #10;
        op_ctrl = 0;
        #10

        op = 4'hb;
        #30
        op_ctrl = 1;
        #10;
        op_ctrl = 0;
        #10

        num = 8'd100;
        #30
        op_ctrl = 1;
        #10;
        op_ctrl = 0;
        #10

        num = 8'd85;
        #30
        op_ctrl = 1;
        #10;
        op_ctrl = 0;
        #10

        op = 4'hd;
        #30
        op_ctrl = 1;
        #10;
        op_ctrl = 0;
        #10

        num = 8'd82;
        #30
        op_ctrl = 1;
        #10;
        op_ctrl = 0;
        #10;

    end

mux_keyboard dut(
     .clk(clk),
     .rst(rst),
     .op_ctrl(op_ctrl),
     .number(num),
     .operand(op),
     .valid(valid),
     .out(out)
);


    
    
endmodule