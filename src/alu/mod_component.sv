
module mod3_component(
    input logic [2:0] in,
    output logic [1:0] out
    );

     always_comb begin
        if (in >= 3'd6) out = in - 3'd6;
        else if (in >= 3'd3) out = in - 3'd3;
        else out = in;
    end 

endmodule