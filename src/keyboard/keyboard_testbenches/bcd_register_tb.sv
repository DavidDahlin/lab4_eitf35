`timescale 1ns/1ps

module bcd_reg_testbench();

logic clk = 0;
logic rst, op_ctrl, valid_scan_code;
logic [3:0] bin_val;
logic [9:0] bcd_val;

always #5 clk = ~clk;



initial begin
    rst = 0;
    #5
    rst = 1;
    op_ctrl = 0;
    valid_scan_code = 0;

    bin_val = 2;
    #20;
    valid_scan_code = 1;
    #10;
    valid_scan_code = 0;
    #20;

    bin_val = 5;
    #5;
    valid_scan_code = 1;
    #10;
    valid_scan_code = 0;
    #20;

    bin_val = 5;
    #5
    valid_scan_code = 1;
    #10
    valid_scan_code = 0;
    #20
    op_ctrl = 1;
    #20
    op_ctrl = 0; 


    //256
    bin_val = 2;
    #20;
    valid_scan_code = 1;
    #10
    valid_scan_code = 0;
    #20

    bin_val = 5;
    #5
    valid_scan_code = 1;
    #10
    valid_scan_code = 0;
    #20
    bin_val = 6;
    #5
    valid_scan_code = 1;
    #10
    valid_scan_code = 0;
    #20
    op_ctrl = 1;
    #20
    op_ctrl = 0; 

    //1000
    bin_val = 1;
    #20;
    valid_scan_code = 1;
    #10
    valid_scan_code = 0;
    #20
    bin_val = 0;
    #5
    valid_scan_code = 1;
    #10
    valid_scan_code = 0;
    #20
    bin_val = 0;
    #5
    valid_scan_code = 1;
    #10
    valid_scan_code = 0;
    #20
    bin_val = 0;
    #5
    valid_scan_code = 1;
    #10
    valid_scan_code = 0;
    #20
    op_ctrl = 1;
    #20
    op_ctrl = 0; 

    
    
    
    bin_val = 1;
    #20;
    valid_scan_code = 1;
    #10
    valid_scan_code = 0;
    #20

    bin_val = 5;
    #5
    valid_scan_code = 1;
    #10
    valid_scan_code = 0;
    #20

    bin_val = 5;
    #5
    valid_scan_code = 1;
    #10
    valid_scan_code = 0;
    #20
    op_ctrl = 1;
    #20
    op_ctrl = 0; 
    
    $stop;

end


bcd_register dut(
    .clk(clk),
    .rst(rst),
    .op_ctrl(op_ctrl),
    .binary_val(bin_val),
    .valid_scan_code(valid_scan_code),
    .bcd_value(bcd_val)
);

endmodule
