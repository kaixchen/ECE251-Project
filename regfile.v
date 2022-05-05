module REGFILE (
    input [1:0] selDin,
    input [1:0] selAout,
    input [1:0] selBout,
    input [1:0] flagsIn,
    input write,
    input [7:0] data,
    output wire [7:0] regoutA,
    output wire [7:0] regoutB,
    output wire [1:0] flagsOut
);
    wire C0, C1, C2, C3, C4;
    wire [7:0] Q0, Q1, Q2, Q3;
    wire [1:0] Q4;
    wire [7:0] muxAout, muxBout;

    DECODE decode (.sel(selDin), .A(t0), .B(t1), .C(t2), .D(t3));

    assign C0 = write && t0;
    assign C1 = write && t1;
    assign C2 = write && t2;
    assign C3 = write && t3;

    assign C4 = write;

    REG8 X0 (.D(data), .Q(Q0), .clkR(C0));
    REG8 X1 (.D(data), .Q(Q1), .clkR(C1));
    REG8 X2 (.D(data), .Q(Q2), .clkR(C2));
    REG8 X3 (.D(data), .Q(Q3), .clkR(C3));

    REG2 X4 (.D(flagsIn), .Q(Q4), .clkR(C4));

    MUX4t1 muxA (.A(Q0), .B(Q1), .C(Q2), .D(Q3), .sel(selAout), .R(muxAout));
    MUX4t1 muxB (.A(Q0), .B(Q1), .C(Q2), .D(Q3), .sel(selBout), .R(muxBout));

    assign regoutA = muxAout;
    assign regoutB = muxBout;

    assign flagsOut = Q4;

endmodule