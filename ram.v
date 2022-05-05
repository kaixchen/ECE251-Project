module RAM (
    input [7:0] addr,
    input we,
    input clk,
    input oe,
    inout [15:0] data        // inout port
);
    reg [15:0] ram [0:255];
    reg [15:0] tmp_data;

    always@(posedge clk) begin
        case(we)
            1'b0 : tmp_data = data;
            1'b1 : ram[addr] = data;
        endcase
    end

    assign data = oe & !we ? tmp_data : 16'bzzzzzzzzzzzzzzzz;
    
endmodule