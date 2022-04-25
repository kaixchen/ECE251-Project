module DECODE (
    input [1:0] sel,
    output reg A,
    output reg B,
    output reg C,
    output reg D
);
    always @(*) begin
        case(sel)
        2'b00 : begin
            A <= 1;
            B <= 0;
            C <= 0;
            D <= 0;
        end

        2'b01 : begin
            A <= 0;
            B <= 1;
            C <= 0;
            D <= 0;
        end

        2'b10 : begin
            A <= 0;
            B <= 0;
            C <= 1;
            D <= 0;
        end

        2'b11 : begin
            A <= 0;
            B <= 0;
            C <= 0;
            D <= 1;
        end

        endcase
    end

endmodule