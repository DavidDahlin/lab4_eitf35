`timescale 1ns/1ps

module mem_testbench();
    
    logic clk = 0;
    always #5 clk = ~clk;

    logic ena = 1;
    logic wea = 0;

    logic [12:0] addra = '0;
    logic [7:0] dina = '0;
    logic [7:0] douta;



    initial begin

        dina = 8'd100;
        #10
        wea = 1;
        #10
        wea = 0;
        addra = addra + 1;
        #10 
        
        dina = 8'd130;
        #10
        wea = 1;
        #10
        wea = 0;
        addra = addra + 1;
        #20

        dina = 8'd200;
        #10
        wea = 1;
        #10
        wea = 0;
        addra = addra + 1;
        #20  

        addra = addra - 1;
        #30  
        addra = addra - 1;
        #30  
        addra = addra - 1;
        #30;


    end


    blk_mem_gen_0 dut(
        .clka(clk),
        .ena(ena),
        .wea(wea),
        .addra(addra),
        .dina(dina),
        .douta(douta)
    );

endmodule