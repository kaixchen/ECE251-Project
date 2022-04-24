module RAM (
    input [7:0] addr,
    inout [7:0] data,   // inout
    input we,
    input clk,
    input oe
);
    reg [7:0] ram [7:0];
    reg [7:0] tmp_data;

    always@(posedge clk) begin
        if(we)
            ram[addr] <= data;
        else
            tmp_data <= data;
    end

    assign data = oe & !we ? tmp_data : 8'bzzzzzzzz;
    
endmodule