`timescale 1ns/1ps

module CLK(
    output wire clkout
);
    reg clk;

    always #10 clk = ~clk;
    assign clkout = clk;

    initial begin
        clk = 0;
        #100;
        $dumpfile("out.vcd");
        $dumpvars(0, clkout);
    end
endmodule