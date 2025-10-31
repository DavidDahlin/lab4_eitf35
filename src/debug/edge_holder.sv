`timescale 1ns/1ps

module edge_holder(.
    input logic clk,
    input logic rst,
    input logic edge_in,
    output logic hold
);

logic [15:0] c, c_n;

logic e_l, e_ln;

always_ff @(posedge clk or negedge rst) begin
    if (rst == 1) begin
        e_l <= '0;
        c <= '0;
    end else begin
        e_l <= e_ln;
        c <= c_n;
    end
end

always_comb begin
    c_n = c +1;
    
    if(edge_in == 1) c_n = 0;

end

always_comb begin
    e_ln = e_l;
    
    if(edge_in == 1) e_ln = 1;
    else if (c == 16'hffff) e_ln = 0;
end

assign hold = e_l;
    




    
endmodule