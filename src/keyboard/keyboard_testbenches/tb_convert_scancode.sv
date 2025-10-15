`timescale 1ns / 1ps

module testbench_scancode();
    
    logic clk = 0;
    logic rst = 1;
    logic edge_found;
    logic kb_data_sync, kb_clk_sync;
    logic kb_clk, kb_data;
    logic [7:0] scan_code_out;
    logic [7:0] code_to_display;
    logic [3:0] seg_en;


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
        #10000000; // run for 2 ms
        $finish;
    end

    

    initial begin
        kb_clk = 0;
        kb_data = 0;
        #15400; // offset from clk
        forever #50000 kb_clk = ~kb_clk;
    end

    // logic[23:0] vec = 24'h16F016;
    logic [32:0] vec = {2'b11,8'h16,1'b0, 2'b11, 8'hf0, 1'b0,2'b11,8'h16,1'b0};
    
    always @(negedge kb_clk) begin
        kb_data = vec[0];
        vec <= vec >> 1;
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

    convert_scancode convert_scancode_inst (
        .clk(clk),
        .rst(rst),
        .edge_found(edge_found),
        .serial_data(kb_data_sync),
        .valid_scan_code(valid_scan_code),
        .scan_code_out(scan_code_out)
    );

    keyboard_ctrl keyboard_ctrl_inst (
        .clk(clk),
        .rst(rst),
        .valid_code(valid_scan_code),
        .scan_code_in(scan_code_out),
        .code_to_display(code_to_display),
        .seg_en(seg_en)
    );

    
endmodule