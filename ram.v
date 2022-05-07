// partially referenced from: https://www.intel.com/content/www/us/en/programmable/quartushelp/13.0/mergedProjects/hdl/vlog/vlog_pro_ram_inferred.htm

module RAM (
    input [7:0] addr,
    input [7:0] dataIn,
    input we,
    input clk,
    output wire [7:0] dataOut
);
    reg [7:0] ram [0:255];
    
    integer i;
    initial begin
        for(i = 0; i < 256; i = i + 1) ram[i] = 8'b00000000;
    end
    
    always@(posedge clk) begin
        if(we) ram[addr] = dataIn;
    end

    assign dataOut = ram[addr];

endmodule