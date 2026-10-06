`timescale 1ns/1ps

module tb_input_collector;

    localparam CLK_PERIOD = 1ns;

    logic clk;
    logic nrst;
    logic select;
    logic valid;
    logic [7:0] data;
    logic [7:0] x;
    logic [7:0] y;
    logic [1:0] op;
    /* verilator lint_off UNUSEDSIGNAL */
    logic [7:0] res;
    int unsigned rand_val;
    /* verilator lint_on UNUSEDSIGNAL */
    input_collector dut (
        .clk    (clk),
        .nrst   (nrst),
        .data   (data),
        .select (select),
        .valid  (valid),
        .x      (x),
        .y      (y)
    );

    alu u_conn (
        .x   (x),
        .y   (y),
        .op  (op),
        .res (res)
    );

    task automatic push_values (logic in_select, logic [7:0] in_data, input int cycles);    
        @(negedge clk);
        data = in_data;
        select = in_select;
        repeat (cycles) @(negedge clk);
    endtask

    initial begin
        clk = 1'b0;

        forever begin
            #(CLK_PERIOD / 2);
            clk = ~clk;
        end
    end

    initial begin
        $dumpfile("build/tb_input_collector.fst");
        $dumpvars(0, tb_input_collector);

        op = 2'b00;
        data = 8'd0;
        select = 1'b0;
        nrst = 1'b1;
        #(CLK_PERIOD/3);
        nrst = 1'b0;
        repeat (3) #CLK_PERIOD;
        nrst = 1'b1;
        repeat (3) #CLK_PERIOD;

        fork
            begin
                forever begin
                    @(posedge clk);
                    op = 2'b00;

                    @(posedge clk);
                    op = 2'b01;

                    @(posedge clk);
                    op = 2'b10;

                    @(posedge clk);
                    op = 2'b11;
                end
            end

            begin
                forever begin
                    @(negedge clk);
                    rand_val = $urandom_range(0, 1);
                    valid = rand_val[0];
                end
            end

            begin
                push_values(1'b0, 8'd21, 4);
                push_values(1'b1, 8'd7, 1);
                push_values(1'b1, 8'd2, 0);
                push_values(1'b0, 8'd9, 3);
                push_values(1'b0, 8'd10, 2);
                push_values(1'b1, 8'd11, 6);
                push_values(1'b0, 8'd36, 1);
            end
        join_any
        
        disable fork;
        
        $finish;
    end

endmodule
