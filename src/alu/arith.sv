`timescale 1ns/1ps

import alu_common::*;

module arithmetic (
    input logic [7:0] a,
    input logic [7:0] b,
    input alu_op_t fn,
    output logic [7:0] result,
    output logic overflow,
    output logic sign
    );

    logic [7:0] sum;
    logic carry_out;
    

    always_comb begin
        // defaults
        sign = 1'b0;
        overflow = 1'b0;
        sum = 8'h00;

        case(fn)
            U_ADD : begin // calc A+B
                {overflow, result} = a + b;
            end
            S_ADD : begin
                sum = a + b; // calc A+B signed: new OF def
                overflow = (a[7] & b[7] & (~sum[7])) | ((~a[7]) & (~b[7]) & (sum[7]));
                if(sum[7] == 1) begin
                    result = (~sum) + 1;
                    sign = 1'b1;
                end else begin
                    result = sum;
                end
            end
            U_SUB : begin
                result = a + ((~b) + 8'd1); // calc A+(-b) (unsigned)
                if(b > a) begin
                    overflow = 1'b1;
                end
            end
            S_SUB : begin
                sum = a + (~b + 8'd1); // calc A+(-b): new OF def
                overflow = (b == 8'h80) ? 1'b1 : (a[7] ^ b[7]) & (a[7] ^ sum[7]);
                if(sum[7] == 1) begin
                    result = (~sum) + 1;
                    sign = 1'b1;
                end else begin
                    result = sum;
                end
            end
            default: begin
                result = 8'h00;
            end
        endcase
    end

endmodule