`timescale 1ns/1ps

module calulator_top(
    input logic clk,
    input logic rst,

    // Data Latching (BTNC)
    input logic latch,

    // Keyboard inputs
    input logic kb_data,
    input logic kb_clk,

    // Keyboard Debug
    output logic [7:0] sc,
    output logic [7:0] num,
    output logic [3:0] seg_en,

    // VGA
    output logic[11:0] io_rgb_color,
    output logic io_horizontal_sync,
    output logic io_vertical_sync
    );

    logic [7:0] op, a, b, result;
    logic sign, overflow;

    alu_top alu (
        .a(a), // input a
        .b(b), // input b
        .op(op), // input operand
        .result(result), // out result
        .overflow(overflow), // out overflow 
        .sign(sign) // out sign
    );

    display_top vga_driver (
        .clk(clk), 
        .rst(rst),
        .a(a), // in a 
        .b(b), // in b
        .result(result), // in res
        .sign(sign), // in sign
        .overflow(overflow), // in overflow
        .operand(op), // in operand
        .io_rgb_color(io_rgb_color), // out color
        .io_horizontal_sync(io_horizontal_sync), //idk
        .io_vertical_sync(io_vertical_sync) // idk
    );

    logic [7:0] sc_l;
    logic [7:0] num_l;
    logic [3:0] seg_en_l;
    logic enter_edge;
    logic valid;
    logic [7:0] num_or_operand;
 
    keyboard_top keyboard(
        .clk(clk),
        .rst(rst),
        .kb_clk(kb_clk),
        .kb_data(kb_data),
        .op_ctrl(latch_edge),
        .sc(sc_l),
        .num(num_l),
        .seg_en(seg_en_l),
        .enter_edge(enter_edge),
        .valid(valid),
        .num_or_operand(num_or_operand)
    );

    assign sc = sc_l;
    assign num = num_l;
    assign seg_en = seg_en_l;

    
    logic wea, ena;
    logic [12:0] addra;
    logic [7:0] dina;

    logic[7:0] douta;

    w_n_r_2mem w_n_r_2mem_inst(
        .clk(clk),
        .rst(rst),
        .enter_edge(enter_edge),
        .valid_signal(valid),
        .value(num_or_operand),
        .douta(douta),
        .wea(wea),
        .addra(addra),
        .dina(dina),
        .ena(ena), 
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

    // DATA LATCHING DEBOUNCE
    logic latch_debounced, latch_edge;

    debouncer debounce (
        .clk(clk),
        .rst(rst),
        .button_in(latch),
        .button_out(latch_debounced)
    );

    edge_detector_pos edge_detector (
        .clk(clk),
        .rst(rst),
        .signal(latch_debounced),
        .edge_found(latch_edge)
    );




endmodule