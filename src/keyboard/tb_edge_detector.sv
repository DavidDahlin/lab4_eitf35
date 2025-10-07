`timescale 1ns / 1ps

module testbench_edge_detection_sync();
    
    logic clk = 0;
    logic rst = 1;
    logic edge_found;
    logic kb_data_sync, kb_clk_sync;
    logic kb_clk, kb_data;


    initial begin
        rst = 1;
        @(negedge clk);
        @(negedge clk);
        @(negedge clk);
        rst = 0;        
    end

    always #10 clk = ~clk;

    initial kb_data = 0;

    initial begin
        #2000000; // run for 2 ms
        $finish;
    end

    initial begin
        kb_clk = 0;
        #15400; // offset from clk
        forever #50000 kb_clk = ~kb_clk;
    end

    always @(negedge kb_clk) begin
        kb_data <= $urandom_range(0,1);
    end 

    sync_keyboard sync_keyboard_inst (
        .clk(clk),
        .kb_clk(kb_clk),
        .kb_data(kb_data),
        .kb_clk_sync(kb_clk_sync),
        .kb_data_sync(kb_data_sync)
    );

    edge_detector edge_detector_inst (
        .clk(clk),
        .rst(rst),
        .kb_clk_sync(kb_clk_sync),
        .edge_found(edge_found)
    );

endmodule