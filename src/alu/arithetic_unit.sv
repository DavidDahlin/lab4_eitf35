`timescale 1ns/1ps

module arithmetic (
    input logic [7:0] a,
    input logic [7:0] b,
    input logic [7:0] op,
    output logic [7:0] result,
    output logic overflow,
    output logic sign
    );

    logic [7:0] carry_out, sum;

    always_comb begin
        // defaults
        sign = 1'b0;
        overflow = 1'b0;
        sum = 8'h00;
        carry_out = 8'h00;


        case(op)
            8'd130 : begin // -
                sum = a + (~b + 8'd1); // calc A+(-b): new OF def
                overflow = (b == 8'h80) ? 1'b1 : (a[7] ^ b[7]) & (a[7] ^ sum[7]);
                if(sum[7] == 1) begin
                    result = (~sum) + 1;
                    sign = 1'b1;
                end else begin
                    result = sum;
                end
            end
            8'd131 : begin // +
                sum = a + b; // calc A+B signed: new OF def
                overflow = (a[7] & b[7] & (~sum[7])) | ((~a[7]) & (~b[7]) & (sum[7]));
                if(sum[7] == 1) begin
                    result = (~sum) + 1;
                    sign = 1'b1;
                end else begin
                    result = sum;
                end
            end
            8'd132 : begin
                {carry_out,result} = a * b;
                overflow = carry_out == 8'd0 ? 0 : 1;
            end
            default: begin
                result = 8'h00;
            end
        endcase
    end

endmodule