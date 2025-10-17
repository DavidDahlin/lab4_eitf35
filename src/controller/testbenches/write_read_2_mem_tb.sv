`timescale 1ns/1ps


module w_n_r_2mem_tb ();

    logic clk = 0;
    logic rst;

    logic enter_edge;
    logic valid_signal;
    logic [7:0] value;

    logic [7:0] douta;

    logic wea;
    logic ena;
    logic [12:0] addra;
    logic [7:0] dina; 
    

    logic [7:0] a, b, op;


    always #20 clk = ~clk;

    initial begin
        enter_edge = 0;
        valid_signal = 0;
        value = 0;  
        rst = 0;
        @(posedge clk);
        @(posedge clk);
        rst = 1;
        @(posedge clk);

        value = 8'd1;
        valid_signal = 1'b1;
        @(posedge clk);
        valid_signal = 1'b0;
        @(posedge clk);
        value = 8'd131;
        valid_signal = 1'b1;
        @(posedge clk);
        valid_signal = 1'b0;
        @(posedge clk);
        value = 8'd2;
        valid_signal = 1'b1;
        @(posedge clk);
        valid_signal = 1'b0;
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);

        enter_edge = 1'b1;
        @(posedge clk);
        enter_edge = 1'b0;
        @(posedge clk);


    end

    w_n_r_2mem dut (
        .clk(clk),
        .rst(rst),
        .enter_edge(enter_edge),
        .valid_signal(valid_signal),
        .value(value),
        .douta(douta),
        .ena(ena),
        .wea(wea),
        .addra(addra),
        .dina(dina),
        .a(a),
        .b(b),
        .op(op)
    );


    blk_mem_gen_0 memory(
        .clka(clk),
        .ena(1'b1),
        .wea(wea),
        .addra(addra),
        .dina(dina),
        .douta(douta)
    );




endmodule