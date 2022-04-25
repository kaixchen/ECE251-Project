module DECODE (
    input [1:0] sel,
    output wire A,
    output wire B,
    output wire C,
    output wire D
);

    reg tmp1, tmp2, tmp3, tmp4;

    assign A = tmp1;
    assign B = tmp2;
    assign C = tmp4;
    assign D = tmp4;

    always @(*) begin
        case(sel)
        2'b00 : begin
            tmp1 <= 1;
            tmp2 <= 0;
            tmp3 <= 0;
            tmp4 <= 0;
        end

        2'b01 : begin
            tmp1 <= 0;
            tmp2 <= 1;
            tmp3 <= 0;
            tmp4 <= 0;
        end

        2'b10 : begin
            tmp1 <= 0;
            tmp2 <= 0;
            tmp3 <= 1;
            tmp4 <= 0;
        end

        2'b11 : begin
            tmp1 <= 0;
            tmp2 <= 0;
            tmp3 <= 0;
            tmp4 <= 1;
        end

        endcase
    end

endmodule