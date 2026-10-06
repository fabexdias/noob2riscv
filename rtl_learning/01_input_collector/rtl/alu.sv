module alu (
    input  logic [7:0] x,
    input  logic [7:0] y,
    input  logic [1:0] op,
    output logic [7:0] res
);

    localparam OP_ADD = 2'b00;
    localparam OP_SUB = 2'b01;
    localparam OP_OR  = 2'b10;
    localparam OP_AND = 2'b11;

    always_comb begin
        case (op)
            OP_ADD: res = x + y;
            OP_SUB: res = x - y;
            OP_OR : res = x | y;
            OP_AND: res = x & y;
            default: res = '0;
        endcase
    end

endmodule
