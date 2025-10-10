`timescale 1ns / 1ps

module testbench_demux_keyboard();

logic [3:0] binary_val = '0;

logic [3:0]  vals[] = '{4'd1, 4'd2, 4'd3, 4'd4, 4'd5, 4'd6, 4'd7, 4'd8, 4'd9, 4'd0,
                             4'd10, 4'd11, 4'd12, 4'd13, 4'd14, 4'hF, 4'hE};

logic [3:0] val;

logic [3:0] num;
logic  [3:0] op;
logic enter;


initial begin

    for(int i = 0; i < vals.size(); i++)begin
        val = vals[i];
        #50;
    end
    
end


demux_keyboard dut (
    .binary_val(val),
    .number(num),
    .operand(op),
    .enter_signal(enter)
 );


endmodule
