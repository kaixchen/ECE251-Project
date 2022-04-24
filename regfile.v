`include "decoder.v"
`include "register.v"

module REGFILE (
    input [1:0] Re,
    input write,
    input [7:0] data,
    output [7:0] Q0,
    output [7:0] Q1,
    output [7:0] Q2,
    output [7:0] Q3
);
    wire C0, C1, C2, C3;

    DECODE Decode (.sel(Re), .A(t0), .B(t1), .C(t2), .D(t3));

    assign C0 = write & t0;
    assign C1 = write & t1;
    assign C2 = write & t2;
    assign C3 = write & t3;

    REG8 X0 (.D(data), .Q(Q0), .clkR(C0));
    REG8 X1 (.D(data), .Q(Q1), .clkR(C1));
    REG8 X2 (.D(data), .Q(Q2), .clkR(C2));
    REG8 X3 (.D(data), .Q(Q3), .clkR(C3));

endmodule