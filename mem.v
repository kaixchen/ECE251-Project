module RAM (
    input [7:0] addr,
    input we,
    input clk,
    input oe,
    inout [7:0] data        // inout port
);
    reg [7:0] ram [7:0];
    reg [7:0] tmp_data;

    always@(posedge clk) begin
        case(we)
            1'b0 : tmp_data = data;
            1'b1 : ram[addr] = data;
        endcase
    end

    assign data = oe & !we ? tmp_data : 8'bzzzzzzzz;
    
endmodule