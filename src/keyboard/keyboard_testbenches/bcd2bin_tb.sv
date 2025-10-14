`timescale 1ns / 1ps

module bcd2bin_testbench();
    
    logic [9:0] bcd_val = '0;
    logic [7:0] bin_val;

    initial begin
        bcd_val = 10'b10_0101_0101;
        #20;
        bcd_val = 10'b01_1001_0111;
        #20;
        bcd_val = 10'b00_0110_0100;
        #20;
        bcd_val = 10'b00_0000_0001;
        #20;
        bcd_val = 10'b00_0000_0000;
        
    end

    bcd2bin dut(
        .bcd(bcd_val),
        .bin(bin_val)
    );

endmodule