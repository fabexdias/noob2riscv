module tb_alu;

    logic [7:0] x;
    logic [7:0] y;
    logic [1:0] op;
    logic [7:0] res;

    alu dut (
        .x   (x),
        .y   (y),
        .op  (op),
        .res (res)
    );

    initial begin
        $dumpfile("build/tb_alu.fst");
        $dumpvars(0, tb_alu);

        x = 8'd10;
        y = 8'd3;

        op = 2'b00;
        #1;
        $display("ADD: %0d + %0d = %0d", x, y, res);

        op = 2'b01;
        #1;
        $display("SUB: %0d - %0d = %0d", x, y, res);

        op = 2'b10;
        #1;
        $display("OR : %b | %b = %b", x, y, res);

        op = 2'b11;
        #1;
        $display("AND: %b & %b = %b", x, y, res);

        $finish;
    end

endmodule
