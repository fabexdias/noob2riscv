module input_collector(
    input  logic       clk,
    input  logic       nrst,
    input  logic [7:0] data,
    input  logic       select,
    input  logic       valid,
    output logic [7:0] x,
    output logic [7:0] y
);

    always_ff @(posedge clk or negedge nrst) begin : b_input
        if (!nrst) begin
            x <= '0;
            y <= '0;
        end else begin
            if (valid) 
                case (select)
                    1'b0 : x <= data;
                    1'b1 : y <= data;
                endcase
        end
    end

endmodule
