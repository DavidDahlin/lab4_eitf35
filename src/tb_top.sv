`timescale 1ns / 1ps

module tb_top();
    
    logic clk = 0;
    logic rst = 0;
    logic kb_clk = 0;
    logic kb_data;
    logic op_ctrl = 0;
    logic [7:0] sc;
    logic [7:0] num;
    logic [3:0] seg_en;
    logic enter_edge;
    logic valid;
    logic [7:0] num_or_operand;


    initial begin
        rst = 0;
        @(negedge clk);
        @(negedge clk);
        @(negedge clk);
        rst = 1;        
    end

    always #20 clk = ~clk;

    initial kb_data = 0;

    // initial begin
    //     // #10000000; // run for 2 ms
    //     $finish;
    // end

    

    initial begin
        kb_clk = 0;
        kb_data = 0;
        #15400; // offset from clk
        forever #50000 kb_clk = ~kb_clk;
    end

    // logic[23:0] vec = 24'h16F016;
    logic [98:0] vec_1 = {2'b11,8'h36,1'b0, 2'b11, 8'hf0, 1'b0,2'b11,8'h36,1'b0,2'b11,8'h2E,1'b0, 2'b11, 8'hf0, 1'b0,2'b11,8'h2E,1'b0,2'b11,8'h1E,1'b0, 2'b11, 8'hf0, 1'b0,2'b11,8'h1E,1'b0};
    
    always @(negedge kb_clk) begin
        kb_data = vec_1[0];
        #25000
        vec_1 <= vec_1 >> 1;
    end

    keyboard_top keyboard(
        .clk(clk),
        .rst(rst),
        .kb_data(kb_data),
        .kb_clk(kb_clk),
        .op_ctrl(op_ctrl),
        .sc(sc),
        .num(num),
        .seg_en(seg_en),
        .enter_edge(enter_edge),
        .valid(valid),
        .num_or_operand(num_or_operand)
    );

    
endmodule