`timescale 1ns/1ps

module edge_holder #(
    parameter int W = 0
)(
    input logic clk,
    input logic rst,
    input logic [W:0] edge_in,
    output logic [W:0] hold
);

logic [28:0] c, c_n;

logic [W:0] e_l, e_ln;

always_ff @(posedge clk or negedge rst) begin
    if (rst == 0) begin
        e_l <= '0;
        c <= '0;
    end else begin
        e_l <= e_ln;
        c <= c_n;
    end
end

always_comb begin
    c_n = c +1;
    
    if(edge_in == 1) c_n = '0;

end

always_comb begin
    e_ln = e_l;
    
    if(edge_in != '0) e_ln = edge_in;
    else if (c == 28'hfffffff) e_ln = '0;
end

assign hold = e_l;
    




    
endmodule