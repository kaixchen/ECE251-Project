module REG8 (
    input clkR,
    input [7:0] D,
    output reg [7:0] Q
);
    initial begin
        Q = 8'b0;
    end

    always @(posedge clkR) begin
        Q = D;
    end

endmodule