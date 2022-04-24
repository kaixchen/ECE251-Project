module Mux4t1 (
    input [7:0] A,      // Register input
    input [7:0] B,      // Register input
    input [7:0] C,      // Register input
    input [7:0] D,      // Register input
    input [1:0] sel,       // Rs        
    output reg [7:0] R     // Output
);

    always @(*) begin
        case(sel)
            2'b00 : R <= A;
            2'b01 : R <= B;
            2'b10 : R <= C;
            2'b11 : R <= D;
        endcase
    end
endmodule