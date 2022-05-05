module REG2 (
    input clkR,
    input [1:0] D,
    output reg [1:0] Q
);
    initial begin
        Q = 2'b0;
    end

    always @(posedge clkR) begin
        Q = D;
    end

endmodule